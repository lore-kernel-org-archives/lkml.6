Return-Path: <kernel-hardening-return-12267-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsYAMCSlprOV0DsJvzt/HgHVpQ+OxwP4POJ024D46Iqvu54ie/2Yo1kWa7SaqxhLQU+zLJp
ARC-Seal: i=1; a=rsa-sha256; t=1520545568; cv=none;
        d=google.com; s=arc-20160816;
        b=RA8AcTsJ10MZJK4BqPrO81P3Ms7RB9iFwx89R3JRE0GpBlTRt9SrUh3v08herIpr1d
         BzBKActCdZAK+50g6E4KkYsmzi9kvFoDG8vJt313F0bKhob8bPvmNA8CBcV95BLJzoxT
         0ac9+3PKC5hjR6ZQI1Q0mSmr3GWunEvhM/V1BEd9JWG4/i9QEc7XM8iEC8CArHd2rOn/
         qCRTRz+Xhd6lRZwiXhGlvJKv95vp3CiD4WajXBwyI/gi/ExiGSFhygcjPami+Zlo9Ne/
         s0lSGBSp4gKfdlRbs59UygmvCKv0TyLMTx6YhdiD9rxybDA73X6QF3cx2B87OUBg8ygL
         XcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=QrLpN9Xuo48jmxK0El6J2/qhXp1hSMxLHOrDO04ysvg=;
        b=Y5NHx4uUjvzIqxJtiMzDGHiX/g6WO11lYAkf6KrfCQNs9L8ooigNVuL7/pHVPAn1xd
         QOxVbVIGZ69W6kptB1zpaHV5TPTSSMLFWKIeqJbgQ6nLpN66tD3/zMZnpOky8c3/mjl+
         aAb/8JxCRt/u4ZiLhtmZv7VXUVr6rrXm0Vhc1sEwWnEFc8n/7MOyqSGk5aGkwSyUv+pe
         MyMHtB03KCGOca2k6HZ5ivAopWE5a5UtlYzayytzdQan8zmuN1O52FRtSULQKD8d7+k+
         0akGI0aaKud1lCxZ3fxEiEUMH5m3N4O31wjnSgHqtwazwqDtHmL0J3oKy5gwreqCQuTe
         QymA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=2CeeSLJ3;
       spf=pass (google.com: domain of kernel-hardening-return-12267-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12267-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=2CeeSLJ3;
       spf=pass (google.com: domain of kernel-hardening-return-12267-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12267-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Mar 2018 14:45:47 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2] ima: drop vla in ima_audit_measurement()
Message-ID: <20180308214547.kdeoeozugxffzumn@smitten>
References: <20180308202347.31331-1-tycho@tycho.ws>
 <1520541374.3605.101.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520541374.3605.101.camel@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594402547592935810?=
X-GMAIL-MSGID: =?utf-8?q?1594407590514366761?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Mimi,

On Thu, Mar 08, 2018 at 03:36:14PM -0500, Mimi Zohar wrote:
> On Thu, 2018-03-08 at 13:23 -0700, Tycho Andersen wrote:
> 
> >  /*
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 2cfb0c714967..356faae6f09c 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -288,8 +288,11 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
> >  					      xattr_value, xattr_len, opened);
> >  		inode_unlock(inode);
> >  	}
> > -	if (action & IMA_AUDIT)
> > -		ima_audit_measurement(iint, pathname);
> > +	if (action & IMA_AUDIT) {
> > +		rc = ima_audit_measurement(iint, pathname);
> > +		if (rc < 0)
> > +			goto out_locked;
> > +	}
> > 
> >  	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
> >  		rc = 0;
> 
> Only when IMA-appraisal is enforcing file data integrity should
> process_measurement() ever fail.  Other errors can be logged/audited.

Ok, so previously in ima_audit_measurement() when allocation failed,
there was nothing logged. If we just keep this behavior like below,
does that look good?

Thanks!

Tycho

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 356faae6f09c..4e699bc7adc5 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -289,9 +289,13 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 		inode_unlock(inode);
 	}
 	if (action & IMA_AUDIT) {
-		rc = ima_audit_measurement(iint, pathname);
-		if (rc < 0)
+		int ret;
+
+		ret = ima_audit_measurement(iint, pathname);
+		if (ret < 0 && ima_appraise & IMA_APPRAISE_ENFORCE) {
+			rc = ret;
 			goto out_locked;
+		}
 	}
 
 	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
