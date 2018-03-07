Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvlLAFYrHdMAnJC7us/bmICphVN+gZXe4T8uXGQKwn2flvtQqssbDxc8fKAM5OcbwSVSdtv
ARC-Seal: i=1; a=rsa-sha256; t=1520451822; cv=none;
        d=google.com; s=arc-20160816;
        b=c3dn+gfO2+ju95CUtvdQIckSriXEg+mVNLvwmZg/YDbe+g/e+J/wuzdJUBIeQAWHZx
         doVswcVsUC4zl4BDQ+c5Uf/KxhzuoI89GbqMfeX25T0mF4Kzd7cOzSG5YAJ8Lul2orpX
         DjN5dkBv3RTv85Xkeid43GmX8xm0YFUaLOwN9LnK//1yAQ0xSHnc3bGuAO1UB54MXWpN
         rjKgm/3ErCvI8GT8AS4X+ib6y8dyNRy334cG/AVRcKl5iGQ7TJrGkWNalAFOEA+1s6Ry
         8XpviJHjHh6nuk47BfskV/jmdl3H1iUbrmKRv8lzmlpHdvDSxhdXK9R1NYl/By5PvOvx
         O8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=obwHGKpgJy+fj5yoG4PHuZOeNf8TfxritSTM96QOigA=;
        b=AYMlp1ulg4B9Di2my9ytji5zdTnFz6deupjb9Ij4fgXQaz+wlcYiLq1qxlzcUklqKC
         uel/PxPVlOS2IN10Nxx6FDo0oKoI3cck+AjJ9rf2nCWnqx4d1l2Y7lioGuL4VbqvWaaF
         3mCYUZyT+nRm5aWezbTDOH3W6GAxWP0j6tTC542iyK29+EVDK7OXqgiUOBZ29DZNX86f
         YNDrtGho+LMJZR2URhbhfMjW4kxtgHtQb5oZ3sN9C10+rS4V4ACIXGE2EOn3W0QKX031
         3joEiliQB4D7cm8SYgXIBDX/K9ywJCxy5pmmq3IHnQ73FJoPQ8I8lQ7epIVASCXVg612
         ptzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 074/122] netlink: put module reference if dump start fails
Date: Wed,  7 Mar 2018 11:38:06 -0800
Message-Id: <20180307191740.028215310@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309290070975529?=
X-GMAIL-MSGID: =?utf-8?q?1594309290070975529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Jason A. Donenfeld" <Jason@zx2c4.com>


[ Upstream commit b87b6194be631c94785fe93398651e804ed43e28 ]

Before, if cb->start() failed, the module reference would never be put,
because cb->cb_running is intentionally false at this point. Users are
generally annoyed by this because they can no longer unload modules that
leak references. Also, it may be possible to tediously wrap a reference
counter back to zero, especially since module.c still uses atomic_inc
instead of refcount_inc.

This patch expands the error path to simply call module_put if
cb->start() fails.

Fixes: 41c87425a1ac ("netlink: do not set cb_running if dump's start() errs")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netlink/af_netlink.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2275,7 +2275,7 @@ int __netlink_dump_start(struct sock *ss
 	if (cb->start) {
 		ret = cb->start(cb);
 		if (ret)
-			goto error_unlock;
+			goto error_put;
 	}
 
 	nlk->cb_running = true;
@@ -2295,6 +2295,8 @@ int __netlink_dump_start(struct sock *ss
 	 */
 	return -EINTR;
 
+error_put:
+	module_put(control->module);
 error_unlock:
 	sock_put(sk);
 	mutex_unlock(nlk->cb_mutex);
