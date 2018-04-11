Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48MJOcnhicnlMlwcWGIe9yYbCL71tOa8TD/BzfCpOUNCGBzVrAVCf0KaH8mGIw4h5GFt7Ic
ARC-Seal: i=1; a=rsa-sha256; t=1523473044; cv=none;
        d=google.com; s=arc-20160816;
        b=qA9mFm9AzgAbBdjDL8qKGIs4W6kP5mXhm3odCIusaRMPsrTrJRvnG3VTI+Scrb+sTp
         /M46OZKrR2oazcYN9gmlSctbtTJsRg1Ptn5ssAd0XzM8F9NYpTMiuiK+vdiLZCJcygKI
         +v/NaFtfC/yA923abuy9KTcrWKNuUcUn8FXc80pLas7tO2Eb2Ej0//1outerTxOSCfTX
         b80Lht0//qBuy7ciPTfFGgd6ig+dxhSIwxMQZwJZ7SyobLOd3IJsCUx7Bjs9gFo7q5DM
         HR4kN0bcpBPgXQbp2cnPGSDxzj0jei4z0XQyWX26XD5WmvgI7zyZ2TFcooOPPy4dU8MU
         L8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=bH4/jIF4rRcQpImbxb81G4mgfRQS8kZP+UFRXrjQ+IQ=;
        b=qutmBOASxZHHOv2Fpj6EYhjkEpQyRCIVXQevkPRCeey1SWLNtds02IOqJilKQixhHi
         aMYPiBOS6jdrG90faDid0e4G+8M5kImpBxEehXMx2wJQvP+5FVpRlQb6xPmzrvdsn0Xp
         y+jEQtcwCUeV7fItNXaRfE/C5nQVNM6OgE3mAJrUXkfDDKEc2rgFmYYwEcDODQoQ7wRA
         34ExOZXK1f5Q/WawKyVC4C8uFuIdKLnZhP82q5HuTX4NkEB7E0JQGzEvlvzcml0nnpYG
         +nm0V782LJzf9GsT8gGnaV0kirBZxHcOFJVYN9va8Hds7FIGYEdOpreUPn3ok9MTaHcS
         LoAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liping Zhang <zlpnobody@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 102/310] netfilter: ctnetlink: fix incorrect nf_ct_put during hash resize
Date: Wed, 11 Apr 2018 20:34:01 +0200
Message-Id: <20180411183626.613906223@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476145685972182?=
X-GMAIL-MSGID: =?utf-8?q?1597477271187526182?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liping Zhang <zlpnobody@gmail.com>


[ Upstream commit fefa92679dbe0c613e62b6c27235dcfbe9640ad1 ]

If nf_conntrack_htable_size was adjusted by the user during the ct
dump operation, we may invoke nf_ct_put twice for the same ct, i.e.
the "last" ct. This will cause the ct will be freed but still linked
in hash buckets.

It's very easy to reproduce the problem by the following commands:
  # while : ; do
  echo $RANDOM > /proc/sys/net/netfilter/nf_conntrack_buckets
  done
  # while : ; do
  conntrack -L
  done
  # iperf -s 127.0.0.1 &
  # iperf -c 127.0.0.1 -P 60 -t 36000

After a while, the system will hang like this:
  NMI watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [bash:20184]
  NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [iperf:20382]
  ...

So at last if we find cb->args[1] is equal to "last", this means hash
resize happened, then we can set cb->args[1] to 0 to fix the above
issue.

Fixes: d205dc40798d ("[NETFILTER]: ctnetlink: fix deadlock in table dumping")
Signed-off-by: Liping Zhang <zlpnobody@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_conntrack_netlink.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -890,8 +890,13 @@ restart:
 	}
 out:
 	local_bh_enable();
-	if (last)
+	if (last) {
+		/* nf ct hash resize happened, now clear the leftover. */
+		if ((struct nf_conn *)cb->args[1] == last)
+			cb->args[1] = 0;
+
 		nf_ct_put(last);
+	}
 
 	while (i) {
 		i--;
