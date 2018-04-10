Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+iD545HGzK278FHRicLrfCnRccqeg610A8Hf92uOQ0jjlal7R1loNPtArvZ3HZS6hZvQPf
ARC-Seal: i=1; a=rsa-sha256; t=1523399651; cv=none;
        d=google.com; s=arc-20160816;
        b=jDtaVtFQt9oQxR+ica0AfbItyuhaU9VcOiNekqXHLmbH4nqroRUja8bAP0790KsjKT
         UTxgsSkOj9tyt+SfWcGrQCDgkCnC1000gugYhAh7IT14S1/ovlRoOkQ7b5cFX2cgfQaQ
         AyAmVZKI/gcOcDcFz/KT7S/jzTvRnUAZcFfarT4qZ9DB7fSaU1G1v3Mc7DoGy9OKtInU
         HMw60LdU8fA2fMPSBFOt3T6VUjAkYyEQ54LeLEPxxLeEZq2w6ajCK0SxLg5hAXM7rXAl
         /QreQT7lbUrgjrdn85JeuubM43v418nCivHBCX9MlZqez9cuoXl9a67OcjA6DV7dRun5
         OeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Vt2xzBvWVwBF9k6alg/+OXs1eN6/7o/ZL/alQHXbwt4=;
        b=fVJdSDfz/zuzC4drR7CFADyhhDJjaL2zQtv5QRgCp2eSrhWSgJlXQTzqsh6U41gMqa
         5LLmkE5C4RTiaeoekXlGFfgyUkhlQbMlCVid5JdWlQY6jnb11CU68kVKeY2byJX9zCp5
         cOPRw1atUdb4ME6KDrrsz4Xln4RFsD8b4vbdZiuhSisI0zG3eYl5vubawtAHZJDhvcZb
         sEYE60h/IXfdyGIBH9UBnY055ILvGVOWUmdUT5GAsDOlm30jAm7hptGEu8X8W7dBYoPE
         0rFDMnd3I2aZxqy9IWy28hO/UupbEzUQ/cyfma9tZ27vkRcdeG5ABV2jC/2bnrMewW/b
         +Pqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sowmini Varadhan <sowmini.varadhan@oracle.com>,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 015/138] rds; Reset rs->rs_bound_addr in rds_add_bound() failure path
Date: Wed, 11 Apr 2018 00:23:25 +0200
Message-Id: <20180410212903.899344475@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399879201708927?=
X-GMAIL-MSGID: =?utf-8?q?1597400313135205459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>


[ Upstream commit 7ae0c649c47f1c5d2db8cee6dd75855970af1669 ]

If the rds_sock is not added to the bind_hash_table, we must
reset rs_bound_addr so that rds_remove_bound will not trip on
this rds_sock.

rds_add_bound() does a rds_sock_put() in this failure path, so
failing to reset rs_bound_addr will result in a socket refcount
bug, and will trigger a WARN_ON with the stack shown below when
the application subsequently tries to close the PF_RDS socket.

     WARNING: CPU: 20 PID: 19499 at net/rds/af_rds.c:496 \
		rds_sock_destruct+0x15/0x30 [rds]
       :
     __sk_destruct+0x21/0x190
     rds_remove_bound.part.13+0xb6/0x140 [rds]
     rds_release+0x71/0x120 [rds]
     sock_release+0x1a/0x70
     sock_close+0xe/0x20
     __fput+0xd5/0x210
     task_work_run+0x82/0xa0
     do_exit+0x2ce/0xb30
     ? syscall_trace_enter+0x1cc/0x2b0
     do_group_exit+0x39/0xa0
     SyS_exit_group+0x10/0x10
     do_syscall_64+0x61/0x1a0

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rds/bind.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/rds/bind.c
+++ b/net/rds/bind.c
@@ -114,6 +114,7 @@ static int rds_add_bound(struct rds_sock
 			  rs, &addr, (int)ntohs(*port));
 			break;
 		} else {
+			rs->rs_bound_addr = 0;
 			rds_sock_put(rs);
 			ret = -ENOMEM;
 			break;
