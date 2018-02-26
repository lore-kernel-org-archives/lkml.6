Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226KdGISVpPwC10WDSges9+eMQK8Zef1afH5qVqjpesSQ9HJ2xvRKMmy38v/xjofijzybDnf
ARC-Seal: i=1; a=rsa-sha256; t=1519676574; cv=none;
        d=google.com; s=arc-20160816;
        b=uexcvd3zaDko6WigK11qAslsRViuckVpOjPr9JIlzV+AAEMjWvUeESX3YA0gUMgwOi
         yAUSs/aJioTvnMGKMeUTaGckxZauKLev+8+DPz3LqiUSTGK1ywePvF67RW8kd+Rc6cof
         qlmY3E3yKW43gxhZ4n37sANPR5IWHMKwW8SuUATE+qZlDjp0SrdKAnPL8gNCHdcy0w5K
         wF4YdPoWTT4JdeRcac2vIOL6hNtaBLQmjjJBoPzOtvFg/O7GkMosENAmb4+h/RO36t7z
         8cN8bUQ42Eikqj82QKyEeXiG/E7hOqlt7Cml44Y84505MD5lk6zkE156AzFHylT6gZpi
         aXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HLzt02HCnJgwlRtJ7fgHfKRrC/R+IMm8urnWdMbCBiI=;
        b=NwCSYJMHwasRr0+arv3TXUcDbmYsTE+PI7O/O0BCysaH7J/PTLCvyh0wAxr4qjKe6m
         QQI4UbDjiVs0surniszU5yM4L0+iqsA0qYhfzMG+u1slDFdsdBpJL3CoIs061fMqISXe
         Ys22ZpvAUSXe52apkxylPiWyPxijP7q8gnkeMdAbsBhoFF8GPJrSg6i9V8wTuQ0HYgtm
         K9mO+NrNmUtf0nKBwSHpC/oBPZwdattAgd012vukcbKkFayLug5Ogg852ejtHrIqsDq1
         qzWpuy2NBgOpoDnBtxsqCqa/ZIKRxFOP8gchZ1OvrBcjuHrdvoG3LCzvUofmOLTbteKp
         ULEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.9 36/39] libnvdimm, dax: fix 1GB-aligned namespaces vs physical misalignment
Date: Mon, 26 Feb 2018 21:20:57 +0100
Message-Id: <20180226201645.252595532@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496383639634177?=
X-GMAIL-MSGID: =?utf-8?q?1593496383639634177?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 41fce90f26333c4fa82e8e43b9ace86c4e8a0120 upstream.

The following namespace configuration attempt:

    # ndctl create-namespace -e namespace0.0 -m devdax -a 1G -f
    libndctl: ndctl_dax_enable: dax0.1: failed to enable
      Error: namespace0.0: failed to enable

    failed to reconfigure namespace: No such device or address

...fails when the backing memory range is not physically aligned to 1G:

    # cat /proc/iomem | grep Persistent
    210000000-30fffffff : Persistent Memory (legacy)

In the above example the 4G persistent memory range starts and ends on a
256MB boundary.

We handle this case correctly when needing to handle cases that violate
section alignment (128MB) collisions against "System RAM", and we simply
need to extend that padding/truncation for the 1GB alignment use case.

Cc: <stable@vger.kernel.org>
Fixes: 315c562536c4 ("libnvdimm, pfn: add 'align' attribute...")
Reported-and-tested-by: Jane Chu <jane.chu@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvdimm/pfn_devs.c |   15 ++++++++++++---
 include/linux/kernel.h    |    1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -563,6 +563,12 @@ static struct vmem_altmap *__nvdimm_setu
 	return altmap;
 }
 
+static u64 phys_pmem_align_down(struct nd_pfn *nd_pfn, u64 phys)
+{
+	return min_t(u64, PHYS_SECTION_ALIGN_DOWN(phys),
+			ALIGN_DOWN(phys, nd_pfn->align));
+}
+
 static int nd_pfn_init(struct nd_pfn *nd_pfn)
 {
 	u32 dax_label_reserve = is_nd_dax(&nd_pfn->dev) ? SZ_128K : 0;
@@ -618,13 +624,16 @@ static int nd_pfn_init(struct nd_pfn *nd
 	start = nsio->res.start;
 	size = PHYS_SECTION_ALIGN_UP(start + size) - start;
 	if (region_intersects(start, size, IORESOURCE_SYSTEM_RAM,
-				IORES_DESC_NONE) == REGION_MIXED) {
+				IORES_DESC_NONE) == REGION_MIXED
+			|| !IS_ALIGNED(start + resource_size(&nsio->res),
+				nd_pfn->align)) {
 		size = resource_size(&nsio->res);
-		end_trunc = start + size - PHYS_SECTION_ALIGN_DOWN(start + size);
+		end_trunc = start + size - phys_pmem_align_down(nd_pfn,
+				start + size);
 	}
 
 	if (start_pad + end_trunc)
-		dev_info(&nd_pfn->dev, "%s section collision, truncate %d bytes\n",
+		dev_info(&nd_pfn->dev, "%s alignment collision, truncate %d bytes\n",
 				dev_name(&ndns->dev), start_pad + end_trunc);
 
 	/*
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -46,6 +46,7 @@
 #define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
 
 #define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
+#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
 #define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
 #define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
 #define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
