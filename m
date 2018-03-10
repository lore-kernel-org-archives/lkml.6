Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsALd38Ac1jULzcS/DzkQl7qhj7Km6S9l0uRVNIPgMRRly0CnS7L4lvMvaxjsVymzm8pUxw
ARC-Seal: i=1; a=rsa-sha256; t=1520641197; cv=none;
        d=google.com; s=arc-20160816;
        b=D6iQtZXtL1Wrq4h6KkwBdF0gx/1cpU/of1miiOct2JtuXcSz2lmCwOFPdFhnjH4MSO
         +73D9up4bSUm42ct5zCV6axpR2yKUHFEnHobYoAHuoCKUAbfC+x7MWdGQFYdQXa+TnZ6
         Xgd12szKmkPWCg8t85p6Iu3tLsBNKCKokcqTvhhzULsD0ND7KlM5O9auYa0J87OEaVRx
         SyzqcJRJtsA/oUZbJIDYPuJtO9iP1Sp6iGGYWQVNpW43KdsJUJvP5xJgDa9LNzrEPn0N
         sfOfC/0ZRsgEAy0D2SlRNrq7UZI0bCwmGU+IOb181F42niCvIj2ke9BmOK6wtP4qB5t0
         UnZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nuyAestoZpZgVQheSAUCjU/XYWrWvjBxWzelSddtmog=;
        b=l26lqoO+WRBBlRvBqQ+8Ijd1rd3/IaBpcqOJyshL9My1mkvVxsFkKlokZE5UYfJ8YS
         lvt3AAvfsxcKqeC+aCeF6QrNe6xSwy69kqhkxKJvd61Yafj0w88VB9EP2KbL3r7Run8B
         m7lTQqWouJTHFFvZGOHH/YlvmT8Q7kkv0tPg8NdqIABdsFCn5FJaQamHJmkXPijoMLvL
         Iy2WD4mz4/Dd/P+7f3SvG8ukiuu2qKGbYa9l2nDRVVRssLTfTwIpwPT+zPidEPmZCp72
         lsPEMTedd6XO9zd8ozvTI5LTj0LEAePIYbQ1+QCsDFNZchtZffUF4/3/1ohCga6APcTE
         vBfA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xiong Zhou <xzhou@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 18/36] bridge: check brport attr show in brport_show
Date: Fri,  9 Mar 2018 16:18:34 -0800
Message-Id: <20180310001808.337030039@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507815386940691?=
X-GMAIL-MSGID: =?utf-8?q?1594507864215811707?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 1b12580af1d0677c3c3a19e35bfe5d59b03f737f ]

Now br_sysfs_if file flush doesn't have attr show. To read it will
cause kernel panic after users chmod u+r this file.

Xiong found this issue when running the commands:

  ip link add br0 type bridge
  ip link add type veth
  ip link set veth0 master br0
  chmod u+r /sys/devices/virtual/net/veth0/brport/flush
  timeout 3 cat /sys/devices/virtual/net/veth0/brport/flush

kernel crashed with NULL a pointer dereference call trace.

This patch is to fix it by return -EINVAL when brport_attr->show
is null, just the same as the check for brport_attr->store in
brport_store().

Fixes: 9cf637473c85 ("bridge: add sysfs hook to flush forwarding table")
Reported-by: Xiong Zhou <xzhou@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_sysfs_if.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -229,6 +229,9 @@ static ssize_t brport_show(struct kobjec
 	struct brport_attribute *brport_attr = to_brport_attr(attr);
 	struct net_bridge_port *p = to_brport(kobj);
 
+	if (!brport_attr->show)
+		return -EINVAL;
+
 	return brport_attr->show(p, buf);
 }
 
