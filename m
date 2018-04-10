Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48fhfXrMCXPvRyXbKagA0I+sWMYTTME2w8DY8VTauS3gk6IFEJ9beCMrD9wDQwBXvK7Goog
ARC-Seal: i=1; a=rsa-sha256; t=1523399802; cv=none;
        d=google.com; s=arc-20160816;
        b=CnyDff/lvRUmTtov2dz3cfwR1YeUJBqDQaRbe95nDXaQJGzXkoBM334L4dxWtRz9u5
         tMuLN1KnyPoaVcQFl8RqRkuxKd3i1BAlFbQR4ddi12d2QPyNaNR1fKHJioYKiEA2QbM8
         NlQiycucJn1gZWO9cez0fxcRudCmOTFjtt7dnq2iiKSnzuesDWNLLVhsJs+Db4/cogpF
         H7R2xtJ9eEmpHeJzdQhifxIdEt2Z1t2QhJNWDTe878CvVX0Plheeqv97OFoDg1uVUymY
         IjiqaXfH3gmvUxHor9iQDw8NvefUZV2Dwc6cFEqPHdcDjPc9ukWaG+loFpKBZfdMMSSA
         57Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qFuU25A9yZRtixQTeCoR0qPBFemykALT0r5Zw5wb47I=;
        b=0CKi1wpKd6sSz9UNPDVHGfYHf6kPkufkt3zY3uW10iBNz2P5+WOwcWHIYuOuPuTe8R
         floOSRWx3IEnD4NTJk62BY7JQ4+iBgOaT6kReCOHRM5yY+jUaUYCZPXyVnbNODMDjfhD
         IOMInTIL02IzrK6UUbL346KpCXHuNQbwW1MXgsEJXHBWrPBi5uigSLQrtaa5y0H2jMaZ
         ylgYWsvBOl0WU6luz1haqjxLg2SqkIiOYKk5iwljmWD7tL490AQ1wxUYfOxDWGruWENj
         Z8Jstpd410VFjfoCmj5ndOgwoX15UbrjckUfI9l/2Su7DhsPVVHIJQ1rCh1A9zaGR4DZ
         WPRw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-edac <linux-edac@vger.kernel.org>,
	Borislav Petkov <bp@suse.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 066/138] EDAC, mv64x60: Fix an error handling path
Date: Wed, 11 Apr 2018 00:24:16 +0200
Message-Id: <20180410212909.762307985@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400025524274247?=
X-GMAIL-MSGID: =?utf-8?q?1597400470785565703?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit 68fa24f9121c04ef146b5158f538c8b32f285be5 ]

We should not call edac_mc_del_mc() if a corresponding call to
edac_mc_add_mc() has not been performed yet.

So here, we should go to err instead of err2 to branch at the right
place of the error handling path.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180107205400.14068-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/mv64x60_edac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/edac/mv64x60_edac.c
+++ b/drivers/edac/mv64x60_edac.c
@@ -758,7 +758,7 @@ static int mv64x60_mc_err_probe(struct p
 		/* Non-ECC RAM? */
 		printk(KERN_WARNING "%s: No ECC DIMMs discovered\n", __func__);
 		res = -ENODEV;
-		goto err2;
+		goto err;
 	}
 
 	edac_dbg(3, "init mci\n");
