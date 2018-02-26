Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227anKNl1mxdJ7/uNRO+AIZXgO0ClxSqGSINFmOZ+8HzHQsR4tTLtSqY1DbCc5f+rmxUisKy
ARC-Seal: i=1; a=rsa-sha256; t=1519676690; cv=none;
        d=google.com; s=arc-20160816;
        b=n6aKM5GW+6YDT8cTQP2jwpPS6U6KguAK/cs3nCdeWLw+/Ch5J4HtLWl1y7MV7KeZBz
         HX+S61puHeTL8om5zZxPEoVmKiI5DiTQ997Pra50Hyh2iEyxmN0sJZu3ClSosEsDfYcj
         d87/JcaGd23HnPRjE2zxbAsgFDEio58OFZlthyT1CCWo4q/sQhCf6smwuJow0oryONi0
         v9S2mM+7wV+lZH4jqY0QjTgTo449SPhQocU1SToWe5J53mG3zxGc9Jzuno85aOLUFFO7
         XJYdk7QEZauK8c0nQdhef20VrsjaUoTbH0FvfhRsE0Stq9hIpV1LyHrZsjr+7ew8vJjc
         KVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8KuwRGcaf9w0usa3ep5lyQm08wB9i4oGvxUg7vt3pO4=;
        b=XZXHBVdcKOKvm5SNVbuIcxX1Mura6/3w6LYw550TmEJEmdESnzCS5s/5xQuZDfhWAC
         uf9lsKYL2cBoFfhImwuCeaHORdCN3bT9gBMPT+T9wQx6fRcy+hOembousiq2r+5jVUEh
         dPXNa5fSTejvUX8S9y8r1rvQ1KwqLzD09SYHUw/ljZkuCUTI+bDNEzmQf26edlGCmKAN
         tNbEIS2/3C7yAJhe9sxtm+w8ZEwcOvOOpKu6srqz3Bq1vQpyQKMIfV1y6TYkgWTMr1ij
         +23lY1l4N/1hkMfK9X12nAkvWwdUqEy503gFymTWszV0Ok3fcCz9d46hZRQuJVw2uU9k
         4Huw==
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
Subject: [PATCH 4.14 08/54] cfg80211: fix cfg80211_beacon_dup
Date: Mon, 26 Feb 2018 21:21:45 +0100
Message-Id: <20180226202144.774953452@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495967259015884?=
X-GMAIL-MSGID: =?utf-8?q?1593496505830471656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2863,7 +2863,7 @@ cfg80211_beacon_dup(struct cfg80211_beac
 	}
 	if (beacon->probe_resp_len) {
 		new_beacon->probe_resp_len = beacon->probe_resp_len;
-		beacon->probe_resp = pos;
+		new_beacon->probe_resp = pos;
 		memcpy(pos, beacon->probe_resp, beacon->probe_resp_len);
 		pos += beacon->probe_resp_len;
 	}
