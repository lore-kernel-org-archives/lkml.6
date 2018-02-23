Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsNwyGJ+vrE/q/KZyjjjhwYis640FZl/D90h/jGLvvgUXb+cVBzvzB1IWfFg7XDkcSb4DbW
ARC-Seal: i=1; a=rsa-sha256; t=1519412073; cv=none;
        d=google.com; s=arc-20160816;
        b=0nO3QYg9d/tN5K6wkCnZ0AuVbgB9dEMH74ow/2WUpab/Fxecrxt9iFp6NbAAF4BARu
         tCw2HlLWjPGFw2chEpdqqCOXQAQKGSReBSVhnvZ1Co+ZRkFvo8PAhXGlxIvzzsgJr6BJ
         TnXo26p8csPcY9DpaEulsdlJMDz5I4+Nh9LCHRE8YfzLzNh+PrZGbyJjix9pY/6uojta
         1PeGpBrWhPfwYol1zLePJaZqvCZa6m87kWkd+bHNL8MGtjiOXo+ae/TfznvnPTRmSXHY
         DaJQlRMCTDlLAxZ5DvC7a4AIXUZU4NTMW4PdLugoHkQljXBQSf6h8EIzFv6kzcfeFAg/
         Q6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oDynPZtEzvKVC5e4QNkzQFIdNTMA3r1l1MAbTcmruzk=;
        b=dvaCmW0eIJ2J7tFGGSpb6s8si2UwQeJM0e87USRUTVIwbB0ZttqShUJRUPHhE/zfjF
         8rSjB90DjQS3WAJFhuypiyXb9OvRgsi7cB3SsWqMo7oDluBrk/+Pli5Nk/QSHH4BQ7W3
         pVCm/BeJfd1xewNpxoYvKBlNvpPymx6aoNSU1USUxldjoxCR7Nlz2Wn0HMQJjX7S3b7Y
         nCsZJjWsNud/vZLhAZphcCt/N4Tk/y7KcpJsAExYiWnxi5I05Fiy65poCH+L0IfKe5CN
         oELCuV0nWA8cxb1+Vy1aDSKeFFQpfaOEvAs52ddVrHI9RkZtEvTIUT3+WZP9U/0Ziz5I
         n0Mg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Huang Daode <huangdaode@hisilicon.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Xie XiuQi <xiexiuqi@huawei.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 078/159] trace/xdp: fix compile warning: struct bpf_map declared inside parameter list
Date: Fri, 23 Feb 2018 19:26:26 +0100
Message-Id: <20180223170753.033010739@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219034020003270?=
X-GMAIL-MSGID: =?utf-8?q?1593219034020003270?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xie XiuQi <xiexiuqi@huawei.com>


[ Upstream commit 23721a755f98ac846897a013c92cccb281c1bcc8 ]

We meet this compile warning, which caused by missing bpf.h in xdp.h.

In file included from ./include/trace/events/xdp.h:10:0,
                 from ./include/linux/bpf_trace.h:6,
                 from drivers/net/ethernet/intel/i40e/i40e_txrx.c:29:
./include/trace/events/xdp.h:93:17: warning: ‘struct bpf_map’ declared inside parameter list will not be visible outside of this definition or declaration
    const struct bpf_map *map, u32 map_index),
                 ^
./include/linux/tracepoint.h:187:34: note: in definition of macro ‘__DECLARE_TRACE’
  static inline void trace_##name(proto)    \
                                  ^~~~~
./include/linux/tracepoint.h:352:24: note: in expansion of macro ‘PARAMS’
  __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),  \
                        ^~~~~~
./include/linux/tracepoint.h:477:2: note: in expansion of macro ‘DECLARE_TRACE’
  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
  ^~~~~~~~~~~~~
./include/linux/tracepoint.h:477:22: note: in expansion of macro ‘PARAMS’
  DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
                      ^~~~~~
./include/trace/events/xdp.h:89:1: note: in expansion of macro ‘DEFINE_EVENT’
 DEFINE_EVENT(xdp_redirect_template, xdp_redirect,
 ^~~~~~~~~~~~
./include/trace/events/xdp.h:90:2: note: in expansion of macro ‘TP_PROTO’
  TP_PROTO(const struct net_device *dev,
  ^~~~~~~~
./include/trace/events/xdp.h:93:17: warning: ‘struct bpf_map’ declared inside parameter list will not be visible outside of this definition or declaration
    const struct bpf_map *map, u32 map_index),
                 ^
./include/linux/tracepoint.h:203:38: note: in definition of macro ‘__DECLARE_TRACE’
  register_trace_##name(void (*probe)(data_proto), void *data) \
                                      ^~~~~~~~~~
./include/linux/tracepoint.h:354:4: note: in expansion of macro ‘PARAMS’
    PARAMS(void *__data, proto),   \
    ^~~~~~

Reported-by: Huang Daode <huangdaode@hisilicon.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Fixes: 8d3b778ff544 ("xdp: tracepoint xdp_redirect also need a map argument")
Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/trace/events/xdp.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -8,6 +8,7 @@
 #include <linux/netdevice.h>
 #include <linux/filter.h>
 #include <linux/tracepoint.h>
+#include <linux/bpf.h>
 
 #define __XDP_ACT_MAP(FN)	\
 	FN(ABORTED)		\
