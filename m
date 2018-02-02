Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227lFxToP7UgW1LHTcWkdjKg1X1AzNXSxSBB9CBWqEh8iiZwa3OMFJU317hbd1wsYJxPRfsE
ARC-Seal: i=1; a=rsa-sha256; t=1517591466; cv=none;
        d=google.com; s=arc-20160816;
        b=JtUDKw8wrEYJ3oZJT+mkkKWvZpMPWPuWV5YlaMBaUaofCKPWUqRRLhxH8neEkkqXvj
         +5idvZPdNd6IcC8H7c5E1oeHWb0uj+ioc3KxgwUP8kJsO6nNH8d9xqMp1EvvzUa43Zz3
         2fhzoPigZyknA/pqV7R7jHNLN47ir9J5pnHZLcXBQPoiGy+PEXEPBMkrVUFzQ8KhF91W
         ecq+lUJ9WFnFF4M5hsOjnURMBCpwwhlzzsh4dW/UDeICUAOdqtGj9o/4QvRP8IKsnPRK
         DUaajidl9MeT9GPzovWBIrcXvbwUD/JK3mP5S2IItu5wOjZbYpcvbV5KEyMBcZPPVnbi
         mPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Q42ZVMnFTLLrVidzaifWj6XVYVggj7oTYULss4CZ1NY=;
        b=c5BaluFGPajfxXhdKLfj4KqFXtVl+SxjpQVHjJD3j6SAEhDOel4hAxC52toT4IV8YR
         glXoIHretR1OXFx0sCWpLQ/yyL/sW2upY9WBodDt2WBaQRmi/YXQqrh2Hsqe5nPlKrFk
         RvLmBII2RF091poMICm2nBU8mmSuSQBIWCo915tuMy/+uzmiAWmjEizkXD2t5QrwPdnJ
         dcMefx1RlZt95TtMfH2bDome8FKQ/b7NkRsrj1w/xHIVP6NKGs4HBS2rJ8mKLTDP5Boy
         OsuEIxsTEajQlT2QOJijEkYvP7QTtZGsRfLw9gsDXplBpgws3N7uiBjLJZmhwr7M5bIc
         fvwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vasily Averin <vvs@virtuozzo.com>,
	Scott Mayhew <smayhew@redhat.com>,
	"J. Bruce Fields" <bfields@redhat.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 089/156] race of lockd inetaddr notifiers vs nlmsvc_rqst change
Date: Fri,  2 Feb 2018 17:57:50 +0100
Message-Id: <20180202140844.277091453@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309989626205484?=
X-GMAIL-MSGID: =?utf-8?q?1591309989626205484?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>


[ Upstream commit 6b18dd1c03e07262ea0866084856b2a3c5ba8d09 ]

lockd_inet[6]addr_event use nlmsvc_rqst without taken nlmsvc_mutex,
nlmsvc_rqst can be changed during execution of notifiers and crash the host.

Patch enables access to nlmsvc_rqst only when it was correctly initialized
and delays its cleanup until notifiers are no longer in use.

Note that nlmsvc_rqst can be temporally set to ERR_PTR, so the "if
(nlmsvc_rqst)" check in notifiers is insufficient on its own.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/lockd/svc.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -57,6 +57,9 @@ static struct task_struct	*nlmsvc_task;
 static struct svc_rqst		*nlmsvc_rqst;
 unsigned long			nlmsvc_timeout;
 
+atomic_t nlm_ntf_refcnt = ATOMIC_INIT(0);
+DECLARE_WAIT_QUEUE_HEAD(nlm_ntf_wq);
+
 unsigned int lockd_net_id;
 
 /*
@@ -292,7 +295,8 @@ static int lockd_inetaddr_event(struct n
 	struct in_ifaddr *ifa = (struct in_ifaddr *)ptr;
 	struct sockaddr_in sin;
 
-	if (event != NETDEV_DOWN)
+	if ((event != NETDEV_DOWN) ||
+	    !atomic_inc_not_zero(&nlm_ntf_refcnt))
 		goto out;
 
 	if (nlmsvc_rqst) {
@@ -303,6 +307,8 @@ static int lockd_inetaddr_event(struct n
 		svc_age_temp_xprts_now(nlmsvc_rqst->rq_server,
 			(struct sockaddr *)&sin);
 	}
+	atomic_dec(&nlm_ntf_refcnt);
+	wake_up(&nlm_ntf_wq);
 
 out:
 	return NOTIFY_DONE;
@@ -319,7 +325,8 @@ static int lockd_inet6addr_event(struct
 	struct inet6_ifaddr *ifa = (struct inet6_ifaddr *)ptr;
 	struct sockaddr_in6 sin6;
 
-	if (event != NETDEV_DOWN)
+	if ((event != NETDEV_DOWN) ||
+	    !atomic_inc_not_zero(&nlm_ntf_refcnt))
 		goto out;
 
 	if (nlmsvc_rqst) {
@@ -331,6 +338,8 @@ static int lockd_inet6addr_event(struct
 		svc_age_temp_xprts_now(nlmsvc_rqst->rq_server,
 			(struct sockaddr *)&sin6);
 	}
+	atomic_dec(&nlm_ntf_refcnt);
+	wake_up(&nlm_ntf_wq);
 
 out:
 	return NOTIFY_DONE;
@@ -347,10 +356,12 @@ static void lockd_unregister_notifiers(v
 #if IS_ENABLED(CONFIG_IPV6)
 	unregister_inet6addr_notifier(&lockd_inet6addr_notifier);
 #endif
+	wait_event(nlm_ntf_wq, atomic_read(&nlm_ntf_refcnt) == 0);
 }
 
 static void lockd_svc_exit_thread(void)
 {
+	atomic_dec(&nlm_ntf_refcnt);
 	lockd_unregister_notifiers();
 	svc_exit_thread(nlmsvc_rqst);
 }
@@ -375,6 +386,7 @@ static int lockd_start_svc(struct svc_se
 		goto out_rqst;
 	}
 
+	atomic_inc(&nlm_ntf_refcnt);
 	svc_sock_update_bufs(serv);
 	serv->sv_maxconn = nlm_max_connections;
 
