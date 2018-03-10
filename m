Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtDJv1TyResju8ytA5KrwVRzNdCn/sqNxC+kZmlafPjf733Ae1uCZAY1kOr7vpFrpbAhhNa
ARC-Seal: i=1; a=rsa-sha256; t=1520641308; cv=none;
        d=google.com; s=arc-20160816;
        b=BbHdIcA0HIBjhQwmNLWsWJRoRynXFHoUxqTYqI6cpmHYyCQ2qgSqiPXIXjgGNjT0T9
         k+YhyoN2sVpVdefrGoT4N3p3RWjs4cJDk1y8u0rRJX+hvnE9cG8bwCW0xJ6QfblnDoOm
         HJkyE1lxiFpoY3JA+O3u3mzYDfmugjw76COyI7gDnhcBkknsr/QphWU17af4HHPhvwAA
         ImnWdPStF29m//3Fm1sltqM7XW1cbINNiE0td9ZMkwWLKOqAIQvIfqzBQvhs9K0imVWI
         BdYuiQgSK6F6NkEJz19EzrfpOHeJ+vj8jKAZxLjFTY89hzmabcnGmnbuUx4xkgDs32zg
         RJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=a/tRkKPUy6LvprJ2had3wjgvBGpmzSysWDNuaqiNcG8=;
        b=RuIkrDeLJLwUVColEys885ZJf81os2wlC2hV7bfdWJ4Ful4AFWOdjJ4D2vrRqLPaGg
         kqBXuReUEZk8Ywwlpllqtv/wfesZghxrYNecZNJ7yP/KQYUSFcmW86c6/M4UKQOdlexY
         1E2AEzMszbWEroari7yLkJnukd8Yq/cFr3rOlJfwvFKRg+52faDvEkUP4MmbhIjsSOQN
         dhTpS7shQePWm6sXlQMd2LeR6zGbqIwPIhphw7dE9F1lxNWUi81h9hxpA7i6L9qE4tis
         jw08rBFNdlRe1nejO1JlGmYDKDknMTpoTQYOrNpwv9HK0YkjRDjQNBLW4EK0hqTxbmxH
         XfQg==
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
Subject: [PATCH 4.9 33/65] bridge: check brport attr show in brport_show
Date: Fri,  9 Mar 2018 16:18:33 -0800
Message-Id: <20180310001827.580920633@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507815386940691?=
X-GMAIL-MSGID: =?utf-8?q?1594507980936206019?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -230,6 +230,9 @@ static ssize_t brport_show(struct kobjec
 	struct brport_attribute *brport_attr = to_brport_attr(attr);
 	struct net_bridge_port *p = to_brport(kobj);
 
+	if (!brport_attr->show)
+		return -EINVAL;
+
 	return brport_attr->show(p, buf);
 }
 
