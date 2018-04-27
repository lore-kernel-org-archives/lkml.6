Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpr50ypy5lazooff3VAbpQ2wNLXGulbmgQI0KKWTMz/92Aqj/sRzvxjFRqbFfniF5IITogF
ARC-Seal: i=1; a=rsa-sha256; t=1524837856; cv=none;
        d=google.com; s=arc-20160816;
        b=n5HKaJC+sRUisJXRZfTB4TjoW2bdpkJlZ2D2OiYYxAS/IAtfDHD3fLZ1PhmjZx3/Vz
         Evb9rDZVIbdJPN/mJeCq+fvmJ4iaQh7GTBogLib9rbLccSoF1hl12oltcGpLOAR8n54w
         B1gcHNBBp/vWUXWuyjzWHGEV2a4LwIAk5C8vT7gvlg/GIVWZSRum7h8PuPTTfKoQr18z
         2I7ECB7BDpTPqoNhzo2uvxrluKZHhdDOOwhM0v/CEplpAzOGn5rPdgPlnx88tAg9KXxq
         S+NsffKBr4rB4t4khwX+wTqFMxF2DBMK7ortttPxrmeEebLgDY72ZPgfX0MNBsfKchtR
         8bjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=WeJcdL9aPfc5VnlZhYJRrsh9vxMmWsDhVIuurQi1sss=;
        b=A+H76A5oPAJouqLlK5z60MFJnIWF9fiVsi8olgIA4ltXqodG9S+6MClnzzXPr96UHJ
         ++OuldFBJ2YaMnAc1F6CnLeJz0q5ab2yz6WIKaUSjWXSe8+ot6W4AZi9ReXfGuOdgiW0
         m0AFYsVytTPtF6QcL8ftr/Mk5WAH+JTcT6SMYVHpgbGE2jWCF9t4NqGmZjHJCTkwWs8d
         wZZ1WUQbw17ykX7T2hxZQ+r8sLL5luNXKoRaQ6QUzPaRya6wJenbd7OMoRgL49Ay6L+Y
         6QAoagHqAbNYxNmUcwr++jkjibIfB3njsVTuZgibP4JWT1plOXlQSVG62TS0pn2WrRzf
         g2YA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C1521890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Burton <paul.burton@imgtec.com>,
	Rob Herring <robh@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Frank Rowand <frowand.list@gmail.com>,
	devicetree@vger.kernel.org,
	linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 15/74] OF: Prevent unaligned access in of_alias_scan()
Date: Fri, 27 Apr 2018 15:58:05 +0200
Message-Id: <20180427135710.534544535@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908380295488480?=
X-GMAIL-MSGID: =?utf-8?q?1598908380295488480?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit de96ec2a77c6d06a423c2c495bb4a2f4299f3d9e upstream.

When allocating a struct alias_prop, of_alias_scan() only requested that
it be aligned on a 4 byte boundary. The struct contains pointers which
leads to us attempting 64 bit writes on 64 bit systems, and if the CPU
doesn't support unaligned memory accesses then this causes problems -
for example on some MIPS64r2 CPUs including the "mips64r2-generic" QEMU
emulated CPU it will trigger an address error exception.

Fix this by requesting alignment for the struct alias_prop allocation
matching that which the compiler expects, using the __alignof__ keyword.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14306/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2109,7 +2109,7 @@ void of_alias_scan(void * (*dt_alloc)(u6
 			continue;
 
 		/* Allocate an alias_prop with enough space for the stem */
-		ap = dt_alloc(sizeof(*ap) + len + 1, 4);
+		ap = dt_alloc(sizeof(*ap) + len + 1, __alignof__(*ap));
 		if (!ap)
 			continue;
 		memset(ap, 0, sizeof(*ap) + len + 1);
