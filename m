Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224tYOYm2yQEgdVo5VGm4VUL6EGWjRFrNEH6isLCor7FxrHBwi1aKiWhSg9HA+E4xrXi39wj
ARC-Seal: i=1; a=rsa-sha256; t=1519676177; cv=none;
        d=google.com; s=arc-20160816;
        b=wB/EttJwk+TVNdOdV/qMq+VqpKDD2LyvbHGyX7TEZIrS/6yJHuxMSw1tJcmfvBdvcY
         3VDczILUW57hs/iT8rmj6e/dIW6JgNGguecXy/jNMpn3YvxcawhAzJXNxsq/NGWuqhjW
         KtVwcbGPJSzJA2xfX9+mzUTHXuKPNrG5tIr9upXr64RYMw7i6YXk0Eo9rwcMXYqoHBtM
         HZ59IA/hfNA7UWOU2S0ysKaBJgWPmLmJQisjAWxB9Udsaa3KNX5hx/K16laNQ7WocQUY
         MK4SW/edtpvybNpwhkvLcRg8tsDMo86sHQHgNWK+zYpsFWRTQ6YdGuq5cFfMftlymMsI
         N2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5Z5ND4VKO+piTp53D0t47+mf2zVv3/SkL1KkTapJIxo=;
        b=VjvLtL48apdKCcxPmrX3J2hqA6B4cQhxgjx9zrIBtyjukqpxo0sfJu0ZDuxiQIgf21
         aVqPLSvX+TETCyd75lvUz8mtFR4unkYsbvkHsJJrE1tYv/5ZXSD43If6OrZPr6LDF87s
         8VSoy9Utft3QGTZ13nOMquhsTnGNeKChz5AnMNSWY202B7YEs5H19FfjCFQHGGwmeUAp
         c7KhRgmFF2wM5mnbjyB9MtngrUDM+qHzY5IezRhEiG0WdmEkql+IswUq9ptnY4CnKgWZ
         UQ61cew0HJIuE5k8QcI1JwOZe9MMcDG5zRWOkIQt4doekZHoGn7lS+ZPu1sBtm5kzYRy
         szew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3.18 05/13] cfg80211: fix cfg80211_beacon_dup
Date: Mon, 26 Feb 2018 21:15:33 +0100
Message-Id: <20180226201527.479367174@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201527.242286068@linuxfoundation.org>
References: <20180226201527.242286068@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495967259015884?=
X-GMAIL-MSGID: =?utf-8?q?1593495967259015884?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit bee92d06157fc39d5d7836a061c7d41289a55797 upstream.

gcc-8 warns about some obviously incorrect code:

net/mac80211/cfg.c: In function 'cfg80211_beacon_dup':
net/mac80211/cfg.c:2896:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]

>From the context, I conclude that we want to copy from beacon into
new_beacon, as we do in the rest of the function.

Cc: stable@vger.kernel.org
Fixes: 73da7d5bab79 ("mac80211: add channel switch command and beacon callbacks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/cfg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2769,7 +2769,7 @@ cfg80211_beacon_dup(struct cfg80211_beac
 	}
 	if (beacon->probe_resp_len) {
 		new_beacon->probe_resp_len = beacon->probe_resp_len;
-		beacon->probe_resp = pos;
+		new_beacon->probe_resp = pos;
 		memcpy(pos, beacon->probe_resp, beacon->probe_resp_len);
 		pos += beacon->probe_resp_len;
 	}
