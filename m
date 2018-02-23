Return-Path: <dan.j.williams@intel.com>
X-Google-Smtp-Source: AH8x227RtGQW79SP/OQWIcNtXoc2X5lc064raz9eK0LFgKZDAhn4LpeEibNvV7mmAZafjmYFGqGy
ARC-Seal: i=1; a=rsa-sha256; t=1519424111; cv=none;
        d=google.com; s=arc-20160816;
        b=Ejg59lP/Wi0Hu1zQ1pYAb3D5UWlh2KuuGwjjj1sD/CAivxTok06+Ev6/rUOucYnkqF
         s4QD2GA+qe5CnHSZKXZdvQ37/gUfblMLUeLPez5LEUerClb71Ub6XDoJn5r1cgVl9i6w
         MH1d6WookIGyY15+3OggzOEG+sUtea7h+s7AXWlNWo/yl9SipcRtg21ov8GHRQmdGLbv
         XM5ZiUXUK/BnIaO7elAjwHze63hv0/rLglZVmJZvFtmmbE8xMc7kK2EepVOGN+vtEuzC
         phD8vvMd9qzW9dWDAXH7XaZMsIRFTtC57JQ2UKuitY4BKnGojGxRaNuOCFyw22iQZRv3
         xIZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject
         :arc-authentication-results;
        bh=/e7OhTY9+CiAWyx42qx4dR8VbBr/U63iUI0aTjknGIY=;
        b=Vx8Wy/zTNlmsc/CTDvD7fHBdByBCCEIiBEnqyFprpDi0lPJcUVEQDZIsrHICLAS5/a
         xHv/D3tR4aEs+B9VCbeEtKW7E6fXKnT7GBWe+VSm05lPW0rIGwxbz0qS5C8Sy9dJE0aT
         3LLBnI+tb+Q7NBI1EuqFfuYCy5onCPPGb7Ip5Mkx1Q9TgAdOue0dqqDTeUKcrymVDpdC
         aTdI/+oaxmAL663F+EQdKkhbXIi5TE0v0I7+017pO/RctaCNOd3AYL6ZCAnjIJko+n5U
         bHYVIVx/aALwDA+qi9y5JE2lCcWrL++FLXo9UeIUHLEaZV6UlHEosIB1pK82yYkQ+OJP
         fVoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dan.j.williams@intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=dan.j.williams@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="20369164"
Subject: [4.9-stable PATCH 08/11] libnvdimm,
 dax: fix 1GB-aligned namespaces vs physical misalignment
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Cc: Jane Chu <jane.chu@oracle.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Bcc: dan.j.williams@intel.com
Date: Fri, 23 Feb 2018 14:06:05 -0800
Message-ID: <151942356576.21775.15139045279160411096.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593231657017023174?=
X-GMAIL-MSGID: =?utf-8?q?1593231657017023174?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 drivers/nvdimm/pfn_devs.c |   15 ++++++++++++---
 include/linux/kernel.h    |    1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 42abdd2391c9..d6aa59ca68b9 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -563,6 +563,12 @@ static struct vmem_altmap *__nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
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
@@ -618,13 +624,16 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
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
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index bc6ed52a39b9..61054f12be7c 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -46,6 +46,7 @@
 #define REPEAT_BYTE(x)	((~0ul / 0xff) * (x))
 
 #define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
+#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
 #define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
 #define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
 #define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
