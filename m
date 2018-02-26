Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuYhiNZmOGAORV4X+aN8rbHl/GF/XLPBQTeSVCuJxmX2rhuBPPMPcsO7e9/wYyYifUTJ2yC
ARC-Seal: i=1; a=rsa-sha256; t=1519676556; cv=none;
        d=google.com; s=arc-20160816;
        b=tr+TlUjjCGeT/YLiMp1wbUXPXSEi9eBVFtfwsTR4St3WWnSNFXKk/dKoITztSG8VrE
         fcvqRzjXnOQPqNta2TrHY3q7ftF3E+2N4qgLP2rYzpGPFVEkTZXW+ct7xyVmlxSvw/S7
         LPOQiLuK2V4PT0BwH/z4+O2wHdBsehc6y9e//KNYNE128s1CjIG2s7eha6v9lTSS8ssn
         nRySc6j9L9ttCsQ5ojSU6b7csyrJm87YM0GFSqBpHYVS376M9M4MmcNNcviM4qoAqeg3
         I7IYMe181vGZORaaNEhgIywo15SILFUQjFq1NFhixUEru6ktEqQsb1jCipywyFzujrL0
         4Lcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=48oon8vp3pV8s5lBibPPNkU+kJ+E3NZ7kBPZJ6vMR0g=;
        b=wB1T3PY73oqhDNolKs6ppnx802TQaW0DLUuFtDt2QbtObtcHRHWDHaERMISJuR0PSt
         wrbbSNHQDWUV7f/1m3ojVGiny/tBnDL38mIU+DPnBMixa8IJTQRQcZ1V9GIEafGQy0l9
         QndYr45OA1yDRpGcVoSGRWd0/4hr2NSTNv+aJMyUlM8KTIpbDp0z5QqnLdLqwGKmCMx3
         WAyJtaRQz6i3ohQuLIwf3WpyyHrqGK9xaMlj/oh5CFsxVP8CN07eHoEF9Z0rW1MM3Wf6
         qsi0pmChmPi7iIWEVZHer2hp4qWyAMTtsvw/20RVWa+mYt8ds2djuvCQPIAF1Ws30do8
         rw9w==
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
Subject: [PATCH 4.9 04/39] cfg80211: fix cfg80211_beacon_dup
Date: Mon, 26 Feb 2018 21:20:25 +0100
Message-Id: <20180226201643.844709938@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495967259015884?=
X-GMAIL-MSGID: =?utf-8?q?1593496364486673284?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2792,7 +2792,7 @@ cfg80211_beacon_dup(struct cfg80211_beac
 	}
 	if (beacon->probe_resp_len) {
 		new_beacon->probe_resp_len = beacon->probe_resp_len;
-		beacon->probe_resp = pos;
+		new_beacon->probe_resp = pos;
 		memcpy(pos, beacon->probe_resp, beacon->probe_resp_len);
 		pos += beacon->probe_resp_len;
 	}
