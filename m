Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtQoDgugXXSQCjhGC+UgxDN1TiqtKJoT9ydijDf+hlXj0wnGO+pPfjM1VrZ+qs26esIXGeY
ARC-Seal: i=1; a=rsa-sha256; t=1521214844; cv=none;
        d=google.com; s=arc-20160816;
        b=XE3LRocvS8tYBiksSqnmg7TRbHXQeJN9xt1DuB17ZoOQZd1EBhV6z9XwYnRPKijc0b
         yw7rugAFxznhzIh2caKiWYLPRFjSTATuQRTq8+yXL0xcwAdjavIC1qSPvA/hccWUNlIy
         ha5qAwJJH1EU8pIo9XvgoMlYzihVrvpA4i8jEa9GKFAdXnrorgTgzlqH1InCFV6RrK9b
         iZk1YBuDIO4vYufC5RRabWkhKwm9vHza5I5MGrh3B7qy3dNGR7LiO/F5EtvgJAysKGGk
         TtL2WiOavHczrFnt61b4en6nmb8XCOEhkoDax+pSfIOwODPzbBaDzGEUef8PcpE0cjxV
         E43A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eNeAsf+V/Qv0/NhgMz1rmUKVN11agHSHdiRr2NHp64A=;
        b=qRny3wmZBEZhSG7+4izK2MoGuGsNGVt9E/kUthBGNMqT9DQ41GkHP8po9Ecibrd6KP
         guFRAJY4mNup9ajtGXsH6ej4qC1Gae8bwQm68diaf2KEZLY/5XUEpC/iXh3E2CvKidbb
         +cP/vEZwGgUCFJXKmmtYbBpO64//wFzk2Qn3Gk7s6nftRc3hYB5qyrA9uUl58sDLVn3h
         no3qBIqbisELRH0HjDOtXNBbcLstCXL43P40hgvdc2NQybkQguB+7JpFzUILUIbeGWNu
         nXfsjK1cnjP6WFnpf3pvPXYFIHtBxO/Af2OA9j+gq5x20GQLfXIdqrLZtUtFo5WymJN/
         EVmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.15 004/128] ASoC: wm_adsp: For TLV controls only register TLV get/set
Date: Fri, 16 Mar 2018 16:22:25 +0100
Message-Id: <20180316152336.430113758@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109018264296181?=
X-GMAIL-MSGID: =?utf-8?q?1595109376921587154?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

commit d7789f5bcdb298c4a302db471b1b20f74a20de95 upstream.

Normal 512-byte get/set of a TLV isn't supported but we were
registering the normal get/set anyway and relying on omitting
the SNDRV_CTL_ELEM_ACCESS_[READ|WRITE] flags to prevent them
being called.

Trouble is if this gets broken in the core ALSA code - as it has
been since at least 4.14 - the standard get/set can be called
unexpectedly and corrupt memory.

There's no point providing functions that won't be called and
it's a trivial change. The benefit is that if the ALSA core gets
broken again we get a big fat immediate NULL dereference instead
of a memory corruption timebomb.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/codecs/wm_adsp.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1204,12 +1204,14 @@ static int wmfw_add_ctl(struct wm_adsp *
 		kcontrol->put = wm_coeff_put_acked;
 		break;
 	default:
-		kcontrol->get = wm_coeff_get;
-		kcontrol->put = wm_coeff_put;
-
-		ctl->bytes_ext.max = ctl->len;
-		ctl->bytes_ext.get = wm_coeff_tlv_get;
-		ctl->bytes_ext.put = wm_coeff_tlv_put;
+		if (kcontrol->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
+			ctl->bytes_ext.max = ctl->len;
+			ctl->bytes_ext.get = wm_coeff_tlv_get;
+			ctl->bytes_ext.put = wm_coeff_tlv_put;
+		} else {
+			kcontrol->get = wm_coeff_get;
+			kcontrol->put = wm_coeff_put;
+		}
 		break;
 	}
 
