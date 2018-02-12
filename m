Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932149AbeBLRrq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:47:46 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:55552 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbeBLRrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:47:43 -0500
Date: Mon, 12 Feb 2018 12:47:38 -0500 (EST)
Message-Id: <20180212.124738.870301786818646917.davem@davemloft.net>
To: dvlasenk@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        linux-decnet-user@lists.sourceforge.net,
        linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-sctp@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-x25@vger.kernel.org
Subject: Re: [PATCH] net: make getname() functions return length rather
 than use int* parameter
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180212141518.3354-1-dvlasenk@redhat.com>
References: <20180212141518.3354-1-dvlasenk@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1CHlm84001696

From: Denys Vlasenko <dvlasenk@redhat.com>
Date: Mon, 12 Feb 2018 15:15:18 +0100

> Before:
> All these functions either return a negative error indicator,
> or store length of sockaddr into "int *socklen" parameter
> and return zero on success.
> 
> "int *socklen" parameter is awkward. For example, if caller does not
> care, it still needs to provide on-stack storage for the value
> it does not need.
> 
> None of the many FOO_getname() functions of various protocols
> ever used old value of *socklen. They always just overwrite it.
> 
> This change drops this parameter, and makes all these functions, on success,
> return length of sockaddr. It's always >= 0 and can be differentiated
> from an error.
> 
> Tests in callers are changed from "if (err)" to "if (err < 0)", where needed.
> 
> rpc_sockname() lost "int buflen" parameter, since its only use was
> to be passed to kernel_getsockname() as &buflen and subsequently
> not used in any way.
> 
> Userspace API is not changed.
> 
>     text    data     bss      dec     hex filename
> 30108430 2633624  873672 33615726 200ef6e vmlinux.before.o
> 30108109 2633612  873672 33615393 200ee21 vmlinux.o
> 
> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>

Please do an allmodconfig build, there are still some conversions you
missed:

security/tomoyo/network.c: In function ¡tomoyo_socket_listen_permission¢:
security/tomoyo/network.c:658:19: warning: passing argument 3 of ¡sock->ops->getname¢ makes integer from pointer without a cast [-Wint-conversion]
            &addr, &addr_len, 0);
                   ^
security/tomoyo/network.c:658:19: note: expected ¡int¢ but argument is of type ¡int *¢
security/tomoyo/network.c:657:21: error: too many arguments to function ¡sock->ops->getname¢
   const int error = sock->ops->getname(sock, (struct sockaddr *)
                     ^~~~
fs/dlm/lowcomms.c: In function ¡lowcomms_error_report¢:
fs/dlm/lowcomms.c:495:6: error: too many arguments to function ¡kernel_getpeername¢
      kernel_getpeername(con->sock, (struct sockaddr *)&saddr, &buflen)) {
      ^~~~~~~~~~~~~~~~~~
fs/dlm/lowcomms.c: In function ¡tcp_accept_from_sock¢:
fs/dlm/lowcomms.c:761:7: warning: passing argument 3 of ¡newsock->ops->getname¢ makes integer from pointer without a cast [-Wint-conversion]
       &len, 2)) {
       ^
fs/dlm/lowcomms.c:761:7: note: expected ¡int¢ but argument is of type ¡int *¢
fs/dlm/lowcomms.c:760:6: error: too many arguments to function ¡newsock->ops->getname¢
  if (newsock->ops->getname(newsock, (struct sockaddr *)&peeraddr,
      ^~~~~~~
