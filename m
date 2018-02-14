Return-Path: <kernel-hardening-return-11783-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x22560cFq1ycZOSQLfNwiTJb2qGipmgB0m/Dkvxe1oqDIn2k/RpKwuMfcTmRW0Vq2Vrq4Nt3O
ARC-Seal: i=1; a=rsa-sha256; t=1518639215; cv=none;
        d=google.com; s=arc-20160816;
        b=aUZmA+qZ2O8X1ksJanYrmLr/3b/ZR8PV8sNnmM5X2dC5/CCg/PAoVSlPfKEiIOpoA3
         1NQl2Dac9B9EZWp9YR2S7qYih58FWIwg2m9+9x5QpF7tDSI4/kLsgIKqVmrk6jiXRAAQ
         lKIBW5zFNvdOUbE8HZJ9O5XSA3jizVVelUdmj1idb7+n/TkpjUZt2n5DqZZt60tqoRK/
         SXr8vQNV5BEV/gsbRYL3MKq1oEtCJFGrKnQGJPC/084gibmwPiCUrSGE3Z9BBBtLj/WT
         Dlbaodvfmi/y2vaVYklVyoi+r1ctgYFIYy+/16oOzzIVmc2RACj26A0Tk/xlDh7X3ct5
         bl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=LXFEDPs1bI5OXhSi+aEQJp/5mPMipUG6b2KyRnSG/Is=;
        b=u577YneoaZBWGxxFVBqoJSe53xx6gOZuyQpoVZilVtamOF6dbbmjAtOfqiJRk3hYHD
         YvGeyz9EfyAVyVosvpEjYr2b1/q/n40/T4t+Kaj1kpjD8USteud7EwY5GiRTDT5ZWKBL
         vCOCraT0sf55dzwMCl5g5zMIw+/2JcalZj9vyF9nxF321KF5Fg0K4VvI6JGz5w7oDLeQ
         ox2CL41CYT1AU9S6Rgl0LD9SfM8PwERh/7BbPRtaseaMXDLk7uwXkQjFUSB7bT34my24
         +DYr4smrMsMvLv4jCb5F/8/uVneU3qtCMThemNuKTO80HfG8ZqVs6+lhBskyn5iWcV6G
         NWnA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=bVMurQ67;
       spf=pass (google.com: domain of kernel-hardening-return-11783-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11783-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=bVMurQ67;
       spf=pass (google.com: domain of kernel-hardening-return-11783-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11783-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
	linux-mm@kvack.org,
	Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Joe Perches <joe@perches.com>
Subject: [PATCH v2 7/8] Convert vhost to kvzalloc_struct
Date: Wed, 14 Feb 2018 12:11:53 -0800
Message-Id: <20180214201154.10186-8-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180214201154.10186-1-willy@infradead.org>
References: <20180214201154.10186-1-willy@infradead.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592408633327089584?=
X-GMAIL-MSGID: =?utf-8?q?1592408633327089584?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Matthew Wilcox <mawilcox@microsoft.com>

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 1b3e8d2d5c8b..fa6c8fa80dd1 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1284,7 +1284,7 @@ static long vhost_set_memory(struct vhost_dev *d, struct vhost_memory __user *m)
 		return -EOPNOTSUPP;
 	if (mem.nregions > max_mem_regions)
 		return -E2BIG;
-	newmem = kvzalloc(size + mem.nregions * sizeof(*m->regions), GFP_KERNEL);
+	newmem = kvzalloc_struct(newmem, regions, mem.nregions, GFP_KERNEL);
 	if (!newmem)
 		return -ENOMEM;
 
-- 
2.15.1
