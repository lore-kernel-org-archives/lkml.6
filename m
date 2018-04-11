Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/tE9LUoIHa/uIdV9IeTcemFGRKz/QRAJDfXCB65R7BMFas3GgWjLg/4YdCls88oLiXVzfc
ARC-Seal: i=1; a=rsa-sha256; t=1523472599; cv=none;
        d=google.com; s=arc-20160816;
        b=V88mYxRjzwZcBbT7Xtr1b2kCAj+Q4HS5YwqO7nPhlc045v7JmI3q6kItAYiHuP1xbt
         n1V9lyWyZPYrs9jG+FufPF7zK6zkxWc5FfoMkkucRg9Bs8zat2abqn65VtlmmaFDOHtJ
         UHwGwkx8rv9GE4SD7TpyKN1ftBZSwXHrgOF42FVOED8dEj+u/IO/fCUNtXuGHOlxDbZn
         1PaeLvKlXJA7a7vuGkUwIaR91gY8BHFxMVToUwC3NPu2yVSHqwSKR2yIryZMatLEUpl2
         jsieMfRlW30pvRVFVwGsiy17gD4Ckx3vULqWpKksfugEW1cECA7Fb5ioh7wtFNbcJ33q
         Mqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iBtE2D1UbwO+jnzu5hZRIY7mpS+JpSReIOMWJKjaSWQ=;
        b=pdLw7058nxmIyQ2UNGuBvFKKjQLbv/ueJYLgC3XrBEZAn4iahWA5sgXI6kWyWp/Xaf
         2d5MGR3UYsu2jgjense2NJ3gSgxotwLsxI6IqZOJB7Q9YYg8pur3ZJnjr4g9R4ZLjrnh
         K0GOuAp65OnPvpAruSvMr6k0QoOnNbkuA9YYrR9S6mac6qpz/RQJHC3y4ssSxoj8ZctM
         nln/kO5c183hXOUL9/e5FPmaaIlTDvREBm0y5CRfQhe5Io0dZVvn6u1rdW5XYcy9HaiW
         0DQlSndzVJMVjspMpWc5JrSOCebFTLxgz1frucd004PC9EHBvJnzoqrsxI23x4FwHCkd
         q1pA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 144/190] cpuidle: dt: Add missing of_node_put()
Date: Wed, 11 Apr 2018 20:36:30 +0200
Message-Id: <20180411183601.054367643@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476804151066112?=
X-GMAIL-MSGID: =?utf-8?q?1597476804151066112?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>


[ Upstream commit b2cdd8e1b54849477a32d820acc2e87828a38f3d ]

'of_node_put()' should be called on pointer returned by
'of_parse_phandle()' when done. In this function this is done in all path
except this 'continue', so add it.

Fixes: 97735da074fd (drivers: cpuidle: Add status property to ARM idle states)
Signed-off-by: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpuidle/dt_idle_states.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -174,8 +174,10 @@ int dt_init_idle_driver(struct cpuidle_d
 		if (!state_node)
 			break;
 
-		if (!of_device_is_available(state_node))
+		if (!of_device_is_available(state_node)) {
+			of_node_put(state_node);
 			continue;
+		}
 
 		if (!idle_state_valid(state_node, i, cpumask)) {
 			pr_warn("%s idle state not valid, bailing out\n",
