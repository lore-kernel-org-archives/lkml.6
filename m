Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtOO5JRiA4oD4YT4q95+qfoMYbJuwFQYuF/3Aid48vif2RDqGotFK+mkGGgr5McJeWfCCKo
ARC-Seal: i=1; a=rsa-sha256; t=1520641375; cv=none;
        d=google.com; s=arc-20160816;
        b=uz2S5TlY3B9Qh56Q7vuGiGJMYANm3evgtzYuKmkLqy4hV8Ag8CLc6UCGMJEN2vz8Tr
         XldD/vSr9Rp3+Hz4azAa/y8YZx8ys33yhXYpssMKQKn+OuUZC/LPLih1ZLeHDiUPdxqp
         bJKIJaxeRAii5UekNMN9ggVS/zELJnKhxDduoSfX3ivpjJN3a8o1MEJnhT+nnAxb3iIH
         qezLN20YQTR7jt4xmK4pyt6AIYVUU1l1BL+BvmWtiiARcQd/KrBBQCkyg2E/Tvz1ixrH
         XeQHK8pETVUHvwElN5Z1EPkUjRaRryP9KAqxmFcgiyx+IvJyFKae5BvGXOHQTGaXZIZW
         aswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MiH8G+xyT5ULpHbtY4m6IdHgr87CItHot2jnNxA0peU=;
        b=ysaNhiOEfZ/mB5Lmy0z7cA6bY3rbDcfcLbtG+Z3u3N91uRulOQm3tDLKYbB8Qk+Pl4
         XvgLZiGVUtPodj8ZuwLFKzPn/8UWITU2YwW64fQfwqx8ox65vxFlPUgnw6As8ky4WJW1
         NBKztmbYySrVagsJPLlhT5fx/EpCmCIkg2O/uyeQKepU89ylEUPdaJaBPm7xNxey4rNK
         V9pAw9j4748pkJsYU3aP/3IXmDILrHLU+8lJQHbRXKeghIQVuOoSNQERIFd7hGELIKEY
         OBsmptZsER1K+zsOI2ibTWj2U0KKsyTv/d9Gui51jNmTG6cV7is8EnIVRLkn5O85r8vE
         TJlw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 31/65] netlink: put module reference if dump start fails
Date: Fri,  9 Mar 2018 16:18:31 -0800
Message-Id: <20180310001827.398247956@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594508051326272872?=
X-GMAIL-MSGID: =?utf-8?q?1594508051326272872?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit b87b6194be631c94785fe93398651e804ed43e28 upstream.

Before, if cb->start() failed, the module reference would never be put,
because cb->cb_running is intentionally false at this point. Users are
generally annoyed by this because they can no longer unload modules that
leak references. Also, it may be possible to tediously wrap a reference
counter back to zero, especially since module.c still uses atomic_inc
instead of refcount_inc.

This patch expands the error path to simply call module_put if
cb->start() fails.

Fixes: 41c87425a1ac ("netlink: do not set cb_running if dump's start() errs")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netlink/af_netlink.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2258,7 +2258,7 @@ int __netlink_dump_start(struct sock *ss
 	if (cb->start) {
 		ret = cb->start(cb);
 		if (ret)
-			goto error_unlock;
+			goto error_put;
 	}
 
 	nlk->cb_running = true;
@@ -2278,6 +2278,8 @@ int __netlink_dump_start(struct sock *ss
 	 */
 	return -EINTR;
 
+error_put:
+	module_put(control->module);
 error_unlock:
 	sock_put(sk);
 	mutex_unlock(nlk->cb_mutex);
