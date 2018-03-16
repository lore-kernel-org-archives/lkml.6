Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsAUEMW84aHlP4R5GtNiJ7m62PnuzPocI7FuCfTZ/CtcLxzfCYHVdQa0fXkwftPm0s0Av92
ARC-Seal: i=1; a=rsa-sha256; t=1521214502; cv=none;
        d=google.com; s=arc-20160816;
        b=FXPitngCOZu66qB+iAK/F86QG5ICZYaQz7x2PwJvFk571ZK8BELAU/kKI5O59NUF3A
         +W+BuML7VNlZ9PLnTtyvwpaNLC/JP7hy4d+RNm0U4hLqrFLJPTueNOyP2zmgrLZswpbk
         R4Q5sEElX6PSFwA6EgGBRpY+L4E+VAK7OIexO1oemQ3eyhQP8e4mZViXNrKihDfcG4Zu
         PlqSOGt/dfLZRpQKhFuhLn94Wc8UxQ70TtIjjtOaE1uiINYP1y7d1q8Ws9LRdfqsQQv+
         ejZk9hgasfKe7xjDvZKTH/8m0TwKgASkLG2dNu9TWjKwYWSoyTWXMayma8PrXS5MRp9G
         JX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nPhYOmG/VBmztX0WnbEtEhVhUos3nR0Ll3WGvoqBILo=;
        b=HBP3G5fmaIwRwI+j8dDdbfpE7XFIFX0Safp2upjDWCvXKTzDCs70gmO0g1DqYLQwJb
         9DF2/PlqR28oO6HTYhugWv/wkcL/UtT80gDx5cnPOrVBdFrPvjgWLA6oTzhEJfFPCJwN
         we1xijR6W9XOeKXn+wFpYI7hXN1Q7vw5qTgvhbJR7HL7dQ0BFJENAMFFeYOcv5xXTpeG
         TJRytlOZThjxLoA2sXq0USNEGIQbLKojsQpIsXiF1o8p4Og1xhjr3U4WKcwF4aDw5Hqs
         Be+w5oXMDvrFacLtDNk+HnY2kPCF+U8DIu+QTfwP1zwDc3SAlux09qP+95Ba0Crg0y0a
         GveQ==
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
Subject: [PATCH 4.14 006/109] ASoC: wm_adsp: For TLV controls only register TLV get/set
Date: Fri, 16 Mar 2018 16:22:35 +0100
Message-Id: <20180316152330.179436218@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109018264296181?=
X-GMAIL-MSGID: =?utf-8?q?1595109018264296181?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
