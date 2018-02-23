Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224L6Xf70yk7rVto9JQyDfmQkXnqtMQBRmNuZNTXC/99QJOcwNOLNmPY3NDS6fa270OOd1Ku
ARC-Seal: i=1; a=rsa-sha256; t=1519411197; cv=none;
        d=google.com; s=arc-20160816;
        b=RAdOY7gF/HmpzRUUWaqymBCIRvp4F0VypujefEMUjAmm3Wpk4QCUtJnjATDdkEa7Mz
         aqxMJBfLeAnmfBJ+OWMqyMjrSKbLePdrAOn9urOVhLFUiSnGxBICIzSGwvPypC0OeYrQ
         FT1nK4YmAa3yZGqvuKUi9hfJO6c8iPtpVUCM1MRkBcRgSufVKot0Y37G86qq1fWztuoa
         8n6E2/hy22JC7f8/i3ToDHL/DVvXiyxozvj4gCrc2IyN13R8q1EsSD8Ab4xZQDixn6rF
         evkK5+FWuGmfCHeGKPrlAxX+3Y2hFKaepFjnbL0cPiI+9Mzzh9G3HWEQC31rXgc/JwXV
         KIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F2+rUK4/RQcO288w6M+h8Nm7PA4QApaQEwx3N7bk7pI=;
        b=eLRVsX1iNhbYY03ia8ms4hMEgmHfwrx74DPxfMKhauQvd3WWrQEuRfljVfa/22CqVk
         HjmMQuDg4rPFFoSwke+DK2mtZ3kU7S+oB4iISihmmfRP3zFs3/DHELLCAV4aDlnLyrQ0
         tgWMD1cSFzWXwi1mpAgoQJekh4axSeXzSXNjzjMG07vjwEPCcEEiDfSbV5jPsAFWsUe1
         ynk17zGpnRyLVsXdBtT0Pm0YVVc2WvlnufLbIrfQk6E161sGNFndsCH/ZSnb1vN0B6zL
         2EZKtC2uwbJc/NtiyNAnx+B4OuIasvUGGGu3PfkQdgT2L7MDczJfS0kPd9DO8aOyYHgT
         Fd4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Julian Anastasov <ja@ssi.bg>,
	Simon Horman <horms@verge.net.au>
Subject: [PATCH 4.4 117/193] netfilter: ipvs: avoid unused variable warnings
Date: Fri, 23 Feb 2018 19:25:50 +0100
Message-Id: <20180223170344.173025093@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218115301335867?=
X-GMAIL-MSGID: =?utf-8?q?1593218115301335867?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit f6ca9f46f6615c3a87529550058d1b468c0cad89 upstream.

The proc_create() and remove_proc_entry() functions do not reference
their arguments when CONFIG_PROC_FS is disabled, so we get a couple
of warnings about unused variables in IPVS:

ipvs/ip_vs_app.c:608:14: warning: unused variable 'net' [-Wunused-variable]
ipvs/ip_vs_ctl.c:3950:14: warning: unused variable 'net' [-Wunused-variable]
ipvs/ip_vs_ctl.c:3994:14: warning: unused variable 'net' [-Wunused-variable]

This removes the local variables and instead looks them up separately
for each use, which obviously avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 4c50a8ce2b63 ("netfilter: ipvs: avoid unused variable warning")
Acked-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/ipvs/ip_vs_app.c |    8 ++------
 net/netfilter/ipvs/ip_vs_ctl.c |   15 ++++++---------
 2 files changed, 8 insertions(+), 15 deletions(-)

--- a/net/netfilter/ipvs/ip_vs_app.c
+++ b/net/netfilter/ipvs/ip_vs_app.c
@@ -605,17 +605,13 @@ static const struct file_operations ip_v
 
 int __net_init ip_vs_app_net_init(struct netns_ipvs *ipvs)
 {
-	struct net *net = ipvs->net;
-
 	INIT_LIST_HEAD(&ipvs->app_list);
-	proc_create("ip_vs_app", 0, net->proc_net, &ip_vs_app_fops);
+	proc_create("ip_vs_app", 0, ipvs->net->proc_net, &ip_vs_app_fops);
 	return 0;
 }
 
 void __net_exit ip_vs_app_net_cleanup(struct netns_ipvs *ipvs)
 {
-	struct net *net = ipvs->net;
-
 	unregister_ip_vs_app(ipvs, NULL /* all */);
-	remove_proc_entry("ip_vs_app", net->proc_net);
+	remove_proc_entry("ip_vs_app", ipvs->net->proc_net);
 }
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -3951,7 +3951,6 @@ static struct notifier_block ip_vs_dst_n
 
 int __net_init ip_vs_control_net_init(struct netns_ipvs *ipvs)
 {
-	struct net *net = ipvs->net;
 	int i, idx;
 
 	/* Initialize rs_table */
@@ -3978,9 +3977,9 @@ int __net_init ip_vs_control_net_init(st
 
 	spin_lock_init(&ipvs->tot_stats.lock);
 
-	proc_create("ip_vs", 0, net->proc_net, &ip_vs_info_fops);
-	proc_create("ip_vs_stats", 0, net->proc_net, &ip_vs_stats_fops);
-	proc_create("ip_vs_stats_percpu", 0, net->proc_net,
+	proc_create("ip_vs", 0, ipvs->net->proc_net, &ip_vs_info_fops);
+	proc_create("ip_vs_stats", 0, ipvs->net->proc_net, &ip_vs_stats_fops);
+	proc_create("ip_vs_stats_percpu", 0, ipvs->net->proc_net,
 		    &ip_vs_stats_percpu_fops);
 
 	if (ip_vs_control_net_init_sysctl(ipvs))
@@ -3995,13 +3994,11 @@ err:
 
 void __net_exit ip_vs_control_net_cleanup(struct netns_ipvs *ipvs)
 {
-	struct net *net = ipvs->net;
-
 	ip_vs_trash_cleanup(ipvs);
 	ip_vs_control_net_cleanup_sysctl(ipvs);
-	remove_proc_entry("ip_vs_stats_percpu", net->proc_net);
-	remove_proc_entry("ip_vs_stats", net->proc_net);
-	remove_proc_entry("ip_vs", net->proc_net);
+	remove_proc_entry("ip_vs_stats_percpu", ipvs->net->proc_net);
+	remove_proc_entry("ip_vs_stats", ipvs->net->proc_net);
+	remove_proc_entry("ip_vs", ipvs->net->proc_net);
 	free_percpu(ipvs->tot_stats.cpustats);
 }
 
