Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuertGLieplptlgreu93Utg5bsyDXQbPpvKcm6BhyjspYdySCeHH+d7Jw/wSQ7Qtnwiknpn
ARC-Seal: i=1; a=rsa-sha256; t=1521214377; cv=none;
        d=google.com; s=arc-20160816;
        b=hXRlFEFsUB2mQY6RG9HFVoYNtMGyOJ+is0BLjBlCtjLRN9Zx4EocFAts0MaPK2dGR+
         qBJOXEWsJmhtovMtn4MqO8OBk/5lN04ttspvayrzwJQCk0gjEW+jphP2HU+e767epLXC
         q3VgTt3E4sGY7yxa8S/iTDAZ/AutByoR4+hIQ56yfxDfMzK2MsdTaaPZmTJc+Tab7U4H
         K0ZSQlFCoRYsGDwh3BRdvw0BJ6pRpjf/Xi+7PZFUkFj/efqEtiVlbRrMxp9M16pFRtwE
         xitq+xzeFiVdgEZXwYgV05HYJUhD2oGIw7zg2AHA6KxAcqImumiWcpEMfJKS1dcmCsAx
         hBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iHYugjuKGCDMb/umYQC4bzC+tRMyPNbP1octyHXBxCY=;
        b=e/4HYmcXWWT8M7SpgM5QExM2G4FhVLZuMZHw6EmiBI2oNLz/iSJKuME7kqppUaHEoo
         XZuOo29ATnzHfh1fhz7BRyrWc+4rblDRlzjxdIT7uQ9FZrj1u508J2Oc/8dyj71VRHPJ
         Qg9IgGZx3A2Ke51dwiIhYHVSFRWQxKAkMe7mjCLi51ysw5Mc/FEUIvR6Y5KzXqdnEMle
         Nby7P9wVdiewZa8dqrkdeGJfoIdM/N37G16HUg8uHocb/yjbSn0Al68mIKP9h3tZsPEY
         Vmm/k2kK6dVAqLAP0w8Oo294HsFzcZBO508F1OGSjMAihpmDajjWfAyJOzYFOaoRg3ZZ
         vQ7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 72/86] ASoC: rt5651: Fix regcache sync errors on resume
Date: Fri, 16 Mar 2018 16:23:35 +0100
Message-Id: <20180316152322.208760495@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108886987469592?=
X-GMAIL-MSGID: =?utf-8?q?1595108886987469592?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 2d30e9494f1ea320aaaad0cff9ddd92c87eac355 upstream.

The ALC5651 does not like multi-write accesses, avoid them. This fixes:

rt5651 i2c-10EC5651:00: Unable to sync registers 0x27-0x28. -121

Errors on resume (and all registers after the registers in the error not
being synced).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/rt5651.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1736,6 +1736,7 @@ static const struct regmap_config rt5651
 	.num_reg_defaults = ARRAY_SIZE(rt5651_reg),
 	.ranges = rt5651_ranges,
 	.num_ranges = ARRAY_SIZE(rt5651_ranges),
+	.use_single_rw = true,
 };
 
 #if defined(CONFIG_OF)
