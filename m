Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48xAzz0bgSnzsew/ioMgOWNp4FOMdNDOZCGe0dd7xKXVQT8PD0MRe5IP2C1NM41Qo14xWQK
ARC-Seal: i=1; a=rsa-sha256; t=1523021737; cv=none;
        d=google.com; s=arc-20160816;
        b=QtDkCqDb7x0pWKy0CGtOtFRvNNfWH/umrFiivg0hAAzMQ5DLNfi6Fk0+T1VXgAc+Fa
         /2/PsolaN4A7qlUp7RdbQXKaxTWC/lvcKh1KVHdDHmbIU08ey4xqhy5xYieUbCiXKCDT
         WHBVz4IJQ9XNRJbDqFWzDbVXkpxjRsnp69sxfY6Q0bdbM+/+wBNm9rGSACv7w/Dd2pmt
         vh2c87jHDV8gHPXQfMPQhYGVCvjJWzQUIr7nz8vikj/b+e81+3wVojbmhYoTxWLPzPuX
         PSjftf9Fv4q9WZep6VCYkCrWzYWU0XRU6lzC1D2Ib4RPhp8Nogn/sz9Vd2PW2wi7YDTg
         xhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5/f31O18qQrQCdxB1kTyk89LkwcOAu3UiHWSZ80HqPs=;
        b=lrUF9SpV7Dc/TKZt+xPSH4yPlQ9+UDe3xqA1e3+4q5AAl96z8sFMIbUti+/acOG6Tm
         HLghpem7tCXmL6FDYo10HuNvOLO619cOzgIwAzuCFjqUGC46Udo87xR+zUzME+ry9+Zf
         YjncZO97qj86EbNREPpHOD6KLMPtV3LJDTcux2H1RhdaZzI0bnAtBHzT2q5QwsvYF48W
         1PpZ8i4reTdHHCt9OlDnEVT/kiLegwI3bW+HL/QqCwapSKXUiNoDVHXxYqqzIfcwOTZ1
         QeuhHpLTBueZdLTlBLsDhGbCHKNr+hOJM5XkYwBb7XactNSCz5vGkcVJDv25qmoFBJpj
         qNrg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 030/102] mac80211: ibss: Fix channel type enum in ieee80211_sta_join_ibss()
Date: Fri,  6 Apr 2018 15:23:11 +0200
Message-Id: <20180406084335.864553789@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004041925163372?=
X-GMAIL-MSGID: =?utf-8?q?1597004041925163372?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit a4ac6f2e53e568a77a2eb3710efd99ca08634c0a upstream.

cfg80211_chandef_create() expects an 'enum nl80211_channel_type' as
channel type however in ieee80211_sta_join_ibss()
NL80211_CHAN_WIDTH_20_NOHT is passed in two occasions, which is of
the enum type 'nl80211_chan_width'. Change the value to NL80211_CHAN_NO_HT
(20 MHz, non-HT channel) of the channel type enum.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/ibss.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -427,7 +427,7 @@ static void ieee80211_sta_join_ibss(stru
 	case NL80211_CHAN_WIDTH_5:
 	case NL80211_CHAN_WIDTH_10:
 		cfg80211_chandef_create(&chandef, cbss->channel,
-					NL80211_CHAN_WIDTH_20_NOHT);
+					NL80211_CHAN_NO_HT);
 		chandef.width = sdata->u.ibss.chandef.width;
 		break;
 	case NL80211_CHAN_WIDTH_80:
@@ -439,7 +439,7 @@ static void ieee80211_sta_join_ibss(stru
 	default:
 		/* fall back to 20 MHz for unsupported modes */
 		cfg80211_chandef_create(&chandef, cbss->channel,
-					NL80211_CHAN_WIDTH_20_NOHT);
+					NL80211_CHAN_NO_HT);
 		break;
 	}
 
