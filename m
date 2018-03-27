Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48Phn2og76MgD+uGEQTibPEDxNHw/5Iex9rBC9RjnpaVFiu++2P3tiEM/57bCSdBEZQ9GdE
ARC-Seal: i=1; a=rsa-sha256; t=1522168335; cv=none;
        d=google.com; s=arc-20160816;
        b=l8KpQwLPWTNjGk8P5AaGVcYS2SCVqV7HogLhaa3Pp3a4am/CGipXloQcmyC9T7SIXa
         9zBbTSZXCHIeaAVceJiY5Xo0tkHIAFJ8RUDu4a9pbiqDkWz9YsIy/hgN5PUU4RIY4NDg
         sOZZ4/Z30+4GwH7Ve3KvUfG+u5lvhi3P2XMOtMBpTOm0ThvdRGfnszEzYGp9TxOYvAw2
         /DztIBmBMaK1MFK+F2PtoCze1Bgs+46q1TREbLcR2qtOi2rdX+KZd6TuuBPYloKuKQoS
         9n8OmZgDHdgkVVuMEb1+dso9t1HUuxGiBQENsmDiCfe1o8S4EMWW2l0yBDL5O0Sv/WeY
         29mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LnQwJtsjI1VIi8jM/rK7eXTnHPLKGog7ixi7xt6blFI=;
        b=acwygvlwaLNF3ETgniVHJd0YYqxqEUew+0LMYvHLb6IooR1iqx08eKNYnJWADbA/28
         yLgy/8AKOmcK/SEdcvqIHO6ogybv480+hG8sEkUDnvd/DEDkRFHoED7b+RU7628mE0s2
         SYMpu39oQ5SbFgiR96az9sqCNSYIv39k0acwnJs2Oe2w4+p6J/20BIpinPp23OI/n+RK
         FdErm0jjUPP8i/xBgnIUi0QqvnQjJEUsqqMwc5+E6oagfL9iwzGUhU55SHaIDjEjFYVo
         VBfZpMHHFAgYVagPM+SfFbU4bFPWyjCIWuxe94RIREfyXr28C9BVOO9EWN7MjyW88qaV
         V4Qw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.9 18/67] libata: disable LPM for Crucial BX100 SSD 500GB drive
Date: Tue, 27 Mar 2018 18:27:10 +0200
Message-Id: <20180327162727.737779781@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109053741544875?=
X-GMAIL-MSGID: =?utf-8?q?1596109184550455748?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit b17e5729a630d8326a48ec34ef02e6b4464a6aef upstream.

After Laptop Mode Tools starts to use min_power for LPM, a user found
out Crucial BX100 SSD can't get mounted.

Crucial BX100 SSD 500GB drive don't work well with min_power. This also
happens to med_power_with_dipm.

So let's disable LPM for Crucial BX100 SSD 500GB drive.

BugLink: https://bugs.launchpad.net/bugs/1726930
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4403,6 +4403,9 @@ static const struct ata_blacklist_entry
 	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
+	/* Crucial BX100 SSD 500GB has broken LPM support */
+	{ "CT500BX100SSD1",		"MU02",	ATA_HORKAGE_NOLPM },
+
 	/* The 512GB version of the MX100 has both queued TRIM and LPM issues */
 	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM |
