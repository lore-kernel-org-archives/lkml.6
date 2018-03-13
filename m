Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvtF5KG1qhc/3GkRYL3Apsa/JCi6Uu8kLlIe7Ird7twKxdJiISNBKxnLykVtD49d9wYtIuk
ARC-Seal: i=1; a=rsa-sha256; t=1520955173; cv=none;
        d=google.com; s=arc-20160816;
        b=Gpsm/eSEVWvhkYeWVCNH+Chaa4f6IKgvteGYCxOaB2XTcmYp91DWKfPf+efz9EzRDX
         VnO04GvjIEaZCX30vmVvVCvUa7ouFZbLU3L7/vPf5FuACDNWH7UuC0F0S2DGXBx5L3z/
         SanhWQWR6fB+zpn5GPunZ/k4CxZ41n01vzObWxE0Ixu6R9xqF0HFcxMLMgWpOdcy+1rm
         X9JVlazx5IBZaWsXnmCUWk2W8s5MuEHRRXFwZDWmqC0i/A5dmcuWnVckf1BL3U/dtK72
         9BjjfVIcMG8gOk3jQmuaAcevol4ZO5HAW0Gz46j5mmm1QiU3l/sL8obqI+pWX0d1MR5F
         EgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SdEJvl/f08az14u02qqkxCLX7qcvsJuX+LhopR1Ebjk=;
        b=alsF7Z18T3blcU2KfcbjGNBoV8hWeWkVkJwuCPto7wwbKmh79H4BRlccu2vM+US1oC
         F0LLBwpkEZI7K24LiPvxLAirCEVMXPmvK885QdEXv+qV/vK0NdrzdCMXKOEx65oDIJYf
         h6b3LhyU5ZEwZu4CiW+0Tq9lERl9zZnpMuOSYb0TE6FxvCi9gy7xkFQ1NkOMTbuZ1sk9
         HXc0WiZRNuAwDwbZW15WWt7P13MDfSJyfcZaj1BFM7okkCuYiQ4xg4oSNtJ9U4vgWXnk
         EIqSjxSuZNOtTVnap17c4E4LrofIl/IueZ1bnqnhw4CzxyfbG5f7gecoMHThYeHJzZU9
         Smbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+845a53d13171abf8bf29@syzkaller.appspotmail.com,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.15 114/146] netfilter: ebtables: CONFIG_COMPAT: dont trust userland offsets
Date: Tue, 13 Mar 2018 16:24:41 +0100
Message-Id: <20180313152329.183444087@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837091715728508?=
X-GMAIL-MSGID: =?utf-8?q?1594837091715728508?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit b71812168571fa55e44cdd0254471331b9c4c4c6 upstream.

We need to make sure the offsets are not out of range of the
total size.
Also check that they are in ascending order.

The WARN_ON triggered by syzkaller (it sets panic_on_warn) is
changed to also bail out, no point in continuing parsing.

Briefly tested with simple ruleset of
-A INPUT --limit 1/s' --log
plus jump to custom chains using 32bit ebtables binary.

Reported-by: <syzbot+845a53d13171abf8bf29@syzkaller.appspotmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/netfilter/ebtables.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2053,7 +2053,9 @@ static int ebt_size_mwt(struct compat_eb
 		if (match_kern)
 			match_kern->match_size = ret;
 
-		WARN_ON(type == EBT_COMPAT_TARGET && size_left);
+		if (WARN_ON(type == EBT_COMPAT_TARGET && size_left))
+			return -EINVAL;
+
 		match32 = (struct compat_ebt_entry_mwt *) buf;
 	}
 
@@ -2109,6 +2111,15 @@ static int size_entry_mwt(struct ebt_ent
 	 *
 	 * offsets are relative to beginning of struct ebt_entry (i.e., 0).
 	 */
+	for (i = 0; i < 4 ; ++i) {
+		if (offsets[i] >= *total)
+			return -EINVAL;
+		if (i == 0)
+			continue;
+		if (offsets[i-1] > offsets[i])
+			return -EINVAL;
+	}
+
 	for (i = 0, j = 1 ; j < 4 ; j++, i++) {
 		struct compat_ebt_entry_mwt *match32;
 		unsigned int size;
