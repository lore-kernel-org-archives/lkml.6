Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225+ktAXe349MjL6S9dj3hjq2vSSAu1pvJmC9rHUhKEj53sIDrfdMESg6hEKBaGJiR7BAnwo
ARC-Seal: i=1; a=rsa-sha256; t=1517591531; cv=none;
        d=google.com; s=arc-20160816;
        b=z+cnPNWIuf9dJaDZGQJVLpLJdCYSlYej2MgM6T56Ava9txsbMFI0ONzFzvoxtmdMZZ
         LqIZw2MITzZUkbDTZhzbGlLaowOKonmL4BQv5Tfj2UX6UTRTS9Eb6wHvTxGCVfQNfNpM
         TcIb3BuG2Th/xi8G4Xk27VaScFMnHcElvpMeXEyZ6TBDPtkCO4sGkHRMmN3psQrqdwfn
         2MNXCTmbKRgHXIvp0/KnzytuyhXExiX2qZ89x+XGNPwS57+UijFuWSogxOAoOaMhEEXS
         khYRPrU2uqCb2tvL3CjQE2ze9wiHPMU9Wie+Zj/jgdYEcL+XVXMIVZYSf2Fpyh/jyY23
         HL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xfG70MIje4QorqUw9IOQcO+wsIWg6UF0dnYmKKWLkbM=;
        b=06vUQwN8lBUheulqdaqd+SqwESAKPo8bKrh8IfC6+aAt9sMl0ipvCd6z48SBYELJXs
         yP/N4rhCdBBVqKkgJCdk35E07QmS1SohMn006VbX73EEKJiHkggo3NtEY0XBl8YeDFbW
         NsFm939ZtnUdjzKDVHNmKPGARWYvczkgu1cirtqSeq+a9HWcMl+kZYAaj8E7i1pL44Zl
         z4yJj6fi++XQd7fbcYjjxuPw+iqWFOimrWLkNG1KPvqi3baDZnjZVdSTRVswXCnJdJbi
         vKh01GSvHRDK9uUoio9KrEDbfR+dAA4kpEm9tzR6K2ax2H3a4RlEWjNobwB4vQDB9Kl5
         NRuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 112/156] drm/omap: Fix error handling path in omap_dmm_probe()
Date: Fri,  2 Feb 2018 17:58:13 +0100
Message-Id: <20180202140845.246322922@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309385535184665?=
X-GMAIL-MSGID: =?utf-8?q?1591310057510035314?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit 8677b1ac2db021ab30bb1fa34f1e56ebe0051ec3 ]

If we don't find a matching device node, we must free the memory allocated
in 'omap_dmm' a few lines above.

Fixes: 7cb0d6c17b96 ("drm/omap: fix TILER on OMAP5")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -638,7 +638,8 @@ static int omap_dmm_probe(struct platfor
 		match = of_match_node(dmm_of_match, dev->dev.of_node);
 		if (!match) {
 			dev_err(&dev->dev, "failed to find matching device node\n");
-			return -ENODEV;
+			ret = -ENODEV;
+			goto fail;
 		}
 
 		omap_dmm->plat_data = match->data;
