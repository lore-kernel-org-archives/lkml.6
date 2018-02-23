Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227iRLpOcTd+sLTy8A14+bvbTzZP8AJYEU8i/AIf/OMyOE0NIS7cW3wwQb4WozpZmQtRmU4n
ARC-Seal: i=1; a=rsa-sha256; t=1519411125; cv=none;
        d=google.com; s=arc-20160816;
        b=E5cN+Ij0n2cFSkyxxBNQQwBueNh66VlL3h9lGh+ZGDBPTuCJibpVLnjbIKfZfxkmcp
         dCzhtHeDzeARwU91YfbrNAgee43sVxCljvISsJZ5BXJp9Ova11YG0H4hkrjPct3MZggA
         M5qtpS1TIvvumga5ujr8B46U0VXAy/yOrTDur3Sfr4MsCFV1+BLPBdQ+GyxNeIWanaUE
         0vkZ+EvSruGnO05HFK5AnPJTvq/YRigsLmj8b5KgRFX9FR3jaFr6xmR0icd0qFOsjyua
         BPSAXC5GlTbxBXiugaubP3ib/N1iwY0bH1/fZ3TcCO0XrxObRf8jw/a6iKpzhN/WC60J
         DuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0p8Y7Y19imx30Dss+adIPn6W608LSKSUXoRCpVMfj1U=;
        b=mrMx49TkHl2RujdUKJQqUIMYKIdvl0yytTp3dv8JPFP2Y2Z4a/Cqnt971uLaIOQQpc
         g4Nilq0G5V6za16zW/rC5LmjG5ETZFK4OfTD2GBWTYBowSyB9kR1DgG3D28J6QrD3vV1
         UCDo+37zRTR49ukwT17jjLWKZ99RAEqcgU8yMHGgDvu4hqvc5cQookp2N3QceZixKoi9
         TRrjmyPT1luKh3D0GwUznmn9vujFNS2sJAtyHL+DQKnuV5XB6T/qZEsPTBoYqQdGygCi
         +zXHZZkdHeSy5u7FMygDJesFVezxHbo/JMFFmoLGvnCUO3uMamRzrvCgJP+vT8IYkJ7E
         6lvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Karol Herbst <karolherbst@gmail.com>,
	Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.4 131/193] drm/nouveau: hide gcc-4.9 -Wmaybe-uninitialized
Date: Fri, 23 Feb 2018 19:26:04 +0100
Message-Id: <20180223170346.350193669@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218040549195447?=
X-GMAIL-MSGID: =?utf-8?q?1593218040549195447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit b74c0a9969f25217a5e5bbcac56a11bee16718d3 upstream.

gcc-4.9 notices that the validate_init() function returns unintialized
data when called with a zero 'nr_buffers' argument, when called with the
-Wmaybe-uninitialized flag:

drivers/gpu/drm/nouveau/nouveau_gem.c: In function ‘validate_init.isra.6’:
drivers/gpu/drm/nouveau/nouveau_gem.c:457:5: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]

However, the only caller of this function always passes a nonzero
argument, and gcc-6 is clever enough to take this into account and
not warn about it any more.

Adding an explicit initialization to -EINVAL here is correct even if
the caller changed, and it avoids the warning on gcc-4.9 as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-By: Karol Herbst <karolherbst@gmail.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/nouveau_gem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -370,7 +370,7 @@ validate_init(struct nouveau_channel *ch
 	struct nouveau_cli *cli = nouveau_cli(file_priv);
 	struct drm_device *dev = chan->drm->dev;
 	int trycnt = 0;
-	int ret, i;
+	int ret = -EINVAL, i;
 	struct nouveau_bo *res_bo = NULL;
 	LIST_HEAD(gart_list);
 	LIST_HEAD(vram_list);
