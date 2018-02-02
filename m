Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224OX4jch/VXZMq60nBkWSBIhplSKnTDDUR3xrDo3WUYlrcpaPFcBFz2vj0+O73YCHjYO38k
ARC-Seal: i=1; a=rsa-sha256; t=1517591377; cv=none;
        d=google.com; s=arc-20160816;
        b=RX3TmdKqwtsGn1Sgq38Jrtp9LeH29FtDjICsJo5CtzT1tV3hR1Y7cdhTBXRcwe7hLW
         8IeFapK8EqQ0qHkHs1gw3vOaolPv9HmWZKTShkjPw41CH3l3S/T/OWrVAHP3x2qhu9iW
         XzuxkUm0iDiuD1/g9YBQHR7KiTp/K5PPOQTdhwsgFOCl4gcWMVcnrXsQLaKFmsIY7EK/
         zDnu9pyCuz7rhSikuRgbqzXcDCy7K2UBh1w4O4hRd0MkXRD7ZFHS31VA1VCDnu/eZzq3
         aGxNN6e1qM4lLk4t8b6gFh5CjtSFJXfwcISLyKx63qYn8Y1p2ppEbjTWUDOvyEZjRJty
         Hy2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TVGsWZo2r82wzaOtBLbex3J4fpQvRBBZBAEiKEh/8gQ=;
        b=M4+PlvbhO6v+UVjYuIijuars3YCarR77GhLTsdm4KgQsiurTBfSIdKuKUS9Rfj2wbH
         2lVC4cpjvPwPYFI4foDrqplUIp+XFgmzv+t2IodlLN6D8Sg1blANckq/KmZSbZ+Ta8vi
         ckJRQdqnwaihV+DL3lcTtfAlWSN8oz90Y+yERRyvZcgJFcQ+VcZNtSIhJlUciIwtc0b1
         yfMzmYADHYsU5QxnKRCI85wZj3ohuKIZCH+/G6gR2tQwokpKi8MNfl8t/LC28r2sqD91
         hFBGrSutf8s8+nwAWD96N4Y+ar81dH30zUTtojwL3Z5Ek2XeFHWIlaUhC5HOsReqnn6u
         Xe+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 058/156] rxrpc: The mutex lock returned by rxrpc_accept_call() needs releasing
Date: Fri,  2 Feb 2018 17:57:19 +0100
Message-Id: <20180202140842.911280244@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309896594608258?=
X-GMAIL-MSGID: =?utf-8?q?1591309896594608258?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>


[ Upstream commit 03a6c82218b9a87014b2c6c4e178294fdc8ebd8a ]

The caller of rxrpc_accept_call() must release the lock on call->user_mutex
returned by that function.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/sendmsg.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -563,8 +563,8 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *
 		/* The socket is now unlocked. */
 		if (IS_ERR(call))
 			return PTR_ERR(call);
-		rxrpc_put_call(call, rxrpc_call_put);
-		return 0;
+		ret = 0;
+		goto out_put_unlock;
 	}
 
 	call = rxrpc_find_call_by_user_ID(rx, p.user_call_ID);
@@ -633,6 +633,7 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *
 		ret = rxrpc_send_data(rx, call, msg, len, NULL);
 	}
 
+out_put_unlock:
 	mutex_unlock(&call->user_mutex);
 error_put:
 	rxrpc_put_call(call, rxrpc_call_put);
