Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49pR+QByKC4aNxHYECmU+sIoAKWEN84fN7N8ec0G6Rn4SKSKmp2dNjJcxO2Et4zxTTvF3z4
ARC-Seal: i=1; a=rsa-sha256; t=1523472635; cv=none;
        d=google.com; s=arc-20160816;
        b=NZEZsIHFzCXhz8hc5nrwcvQSZ8laUm5sn0bkCv5WJ1EJoHPvCOrW1T724cHv0UT6Wz
         km2PomRwBNw6snv+XlNDIKYG1G+rTJrDV+enolRdBfPNbHWAm4hHPVn+l51/4mlkg7xz
         xIuXSRLc8HzHqTtf0CCayI4BjEHJnkxqUYucD0COK3cnDFY+TzF0NvqcOljmcTG51t8D
         XuUf9DMnoZRakOowXMTOgcL4ou4cx5W6PZ/LQmSnl7KqKAPa74Uv1GpGVCSXEWqtkwcq
         m13oNSjqrPxW5NfB3xfDOsRvgrpDBBLbTzHKXJsWc1dn+QXY38awvGlCtiMNV/aqY7OQ
         p6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=82b8UxN5GXHBEg28CNoc//Xa5nF5dDHkdSZGKp7gqMo=;
        b=en0FeWclwzWfB1CvbensmIBh585E/uiDiZlvcWYWJkSNRy7A51qMoY3Il9QuqRD9Jl
         +GrbsrLMu94B7qT/jTTRffXk7O214y4R3zRiNnE4aGDTE+LaY10rlp6OHtx6xQg1lxlD
         TJkOoaVPW0uyQeZEcbPmlgEF7WTbGSTrRN79O2mEOW86aktVzUdGb+wHeVyoZh005SNI
         n+koyhz4iYTfmRo1ZdzXMi51YkhLKDOHW3C08fdeyJh8SdfPCJzR3dj3tLvfTz5ctn9D
         4fvLte5NbrQImfRz2GWeERlbTqgjOcOPjXR24l6DxIhhhtqX92fVa/ARqpKvixZ4e9uc
         lWww==
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
Subject: [PATCH 4.4 156/190] EDAC, mv64x60: Fix an error handling path
Date: Wed, 11 Apr 2018 20:36:42 +0200
Message-Id: <20180411183601.697824604@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476306178591836?=
X-GMAIL-MSGID: =?utf-8?q?1597476841980997678?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -763,7 +763,7 @@ static int mv64x60_mc_err_probe(struct p
 		/* Non-ECC RAM? */
 		printk(KERN_WARNING "%s: No ECC DIMMs discovered\n", __func__);
 		res = -ENODEV;
-		goto err2;
+		goto err;
 	}
 
 	edac_dbg(3, "init mci\n");
