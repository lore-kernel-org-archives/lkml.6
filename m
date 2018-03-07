Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuIKWEH2bUiWRL5uLAiL4y+wvuV1zRarafK+CaDrrZYyKwy4fZ303OxO3Fcbl2BRfiKa/0B
ARC-Seal: i=1; a=rsa-sha256; t=1520451721; cv=none;
        d=google.com; s=arc-20160816;
        b=GZYZFBTtQEQ93YfL5F/k1mhKgOvZVC5sZIzSlkYfr1OU+lTMcJR1ROrFVxm8WIwn4V
         pRKJKqNY0drU65JtIEWapHV5pP4gBLq0NU8N5ha1NYznBS7CNH0wQqCia4D6P/JqcvPy
         3RH9NBUm6M+BO23gVB/RT+yKr/gD4yarxMPC8N5kGxrufo/2bT6eQJ9JOzhd7DjozKmw
         YUuPw1GOD04A0K2FhlWh5hQlm3n897u28uzsBrN9vAWuknWsW5wPDyzaWE8bTM2OqD2N
         WpUijVD8EZh0PZY2M2Ad1huCRlRL68h8eBafO02i20bQTiPTcz4meAJGKAMjCY8UyjME
         aSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mQkMZbNMr2JhLDpi2yT32kUFHSizTPF1gC/xXwy0qYI=;
        b=izKm2vi1PWGQWqmT/EexCXAidwACXkZRjHERxIRY+KcPb9Ky/WV+ieddWhbB9VZ1vx
         TaK6X3D6D74Md164vc9tA0z1N5nSSJmD3R/uqpy0zyt3KcYtcSDjuMH/B1I97HZvaj3k
         te5FlViKtu6X3JjiROBoWLsAQmk1x4SrsgLL6D3t91OsfyM90x8cOfLHWIMUgRE7eN7t
         baPEkkARiT9gd9U8uXa25UQGKUWx4OkpgmmjiYtETjqSlabKmXOoIguoA/EtY8wxB5FW
         aC/rng5hAuquaMXZqoMlRuZ4XHuMFAt5tPYWTRbHdxKbYzLz8ZeBYtWSORsSInotRaoG
         O+xQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ido Schimmel <idosch@mellanox.com>,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 068/122] bridge: Fix VLAN reference count problem
Date: Wed,  7 Mar 2018 11:38:00 -0800
Message-Id: <20180307191739.211643933@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309184895358500?=
X-GMAIL-MSGID: =?utf-8?q?1594309184895358500?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@mellanox.com>


[ Upstream commit 0e5a82efda872c2469c210957d7d4161ef8f4391 ]

When a VLAN is added on a port, a reference is taken on the
corresponding master VLAN entry. If it does not already exist, then it
is created and a reference taken.

However, in the second case a reference is not really taken when
CONFIG_REFCOUNT_FULL is enabled as refcount_inc() is replaced by
refcount_inc_not_zero().

Fix this by using refcount_set() on a newly created master VLAN entry.

Fixes: 251277598596 ("net, bridge: convert net_bridge_vlan.refcnt from atomic_t to refcount_t")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_vlan.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -168,6 +168,8 @@ static struct net_bridge_vlan *br_vlan_g
 		masterv = br_vlan_find(vg, vid);
 		if (WARN_ON(!masterv))
 			return NULL;
+		refcount_set(&masterv->refcnt, 1);
+		return masterv;
 	}
 	refcount_inc(&masterv->refcnt);
 
