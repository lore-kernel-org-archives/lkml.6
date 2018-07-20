Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C334ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FEF20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FEF20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbeGTVfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:35:39 -0400
Received: from www62.your-server.de ([213.133.104.62]:57850 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeGTVfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:35:39 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fgcHP-00032b-ER; Fri, 20 Jul 2018 22:45:35 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fgcHP-0004pa-7e; Fri, 20 Jul 2018 22:45:35 +0200
Subject: Re: [PATCH] bpf: Add Python 3 support to selftests scripts for bpf
To:     Jeremy Cline <jcline@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Lawrence Brakmo <brakmo@fb.com>,
        jakub.kicinski@netronome.com
References: <20180718213610.19618-1-jcline@redhat.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1aa3dc98-2ab1-7386-d5d9-afd3dbb3fde9@iogearbox.net>
Date:   Fri, 20 Jul 2018 22:45:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180718213610.19618-1-jcline@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24767/Fri Jul 20 18:41:48 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/2018 11:36 PM, Jeremy Cline wrote:
> Adjust tcp_client.py and tcp_server.py to work with Python 3 by using
> the print function, marking string literals as bytes, and using the
> newer exception syntax. This should be functionally equivalent and
> support Python 2.6 through Python 3.7.
> 
> Signed-off-by: Jeremy Cline <jcline@redhat.com>

Thanks for the patch, Jeremy! Given we also have test_offload.py in BPF
kselftests and it is written for python 3 only, it would probably make
sense to adapt the tcp_{client,server}.py towards python 3 as well, so
we wouldn't need to keep extra compat for 2 and have a consistent version
dependency. Lawrence / Jeremy, any objections?

>  tools/testing/selftests/bpf/tcp_client.py | 12 ++++++------
>  tools/testing/selftests/bpf/tcp_server.py | 17 +++++++++--------
>  2 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/tcp_client.py b/tools/testing/selftests/bpf/tcp_client.py
> index 481dccdf140c..9fe5f1b5c020 100755
> --- a/tools/testing/selftests/bpf/tcp_client.py
> +++ b/tools/testing/selftests/bpf/tcp_client.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/env python2
> +#!/usr/bin/env python
>  #
>  # SPDX-License-Identifier: GPL-2.0
>  #
> @@ -9,11 +9,11 @@ import subprocess
>  import select
>  
>  def read(sock, n):
> -    buf = ''
> +    buf = b''
>      while len(buf) < n:
>          rem = n - len(buf)
>          try: s = sock.recv(rem)
> -        except (socket.error), e: return ''
> +        except (socket.error) as e: return b''
>          buf += s
>      return buf
>  
> @@ -22,7 +22,7 @@ def send(sock, s):
>      count = 0
>      while count < total:
>          try: n = sock.send(s)
> -        except (socket.error), e: n = 0
> +        except (socket.error) as e: n = 0
>          if n == 0:
>              return count;
>          count += n
> @@ -39,10 +39,10 @@ try:
>  except socket.error as e:
>      sys.exit(1)
>  
> -buf = ''
> +buf = b''
>  n = 0
>  while n < 1000:
> -    buf += '+'
> +    buf += b'+'
>      n += 1
>  
>  sock.settimeout(1);
> diff --git a/tools/testing/selftests/bpf/tcp_server.py b/tools/testing/selftests/bpf/tcp_server.py
> index bc454d7d0be2..1d4a40a6584b 100755
> --- a/tools/testing/selftests/bpf/tcp_server.py
> +++ b/tools/testing/selftests/bpf/tcp_server.py
> @@ -1,7 +1,8 @@
> -#!/usr/bin/env python2
> +#!/usr/bin/env python
>  #
>  # SPDX-License-Identifier: GPL-2.0
>  #
> +from __future__ import print_function
>  
>  import sys, os, os.path, getopt
>  import socket, time
> @@ -9,11 +10,11 @@ import subprocess
>  import select
>  
>  def read(sock, n):
> -    buf = ''
> +    buf = b''
>      while len(buf) < n:
>          rem = n - len(buf)
>          try: s = sock.recv(rem)
> -        except (socket.error), e: return ''
> +        except (socket.error) as e: return b''
>          buf += s
>      return buf
>  
> @@ -22,7 +23,7 @@ def send(sock, s):
>      count = 0
>      while count < total:
>          try: n = sock.send(s)
> -        except (socket.error), e: n = 0
> +        except (socket.error) as e: n = 0
>          if n == 0:
>              return count;
>          count += n
> @@ -43,7 +44,7 @@ host = socket.gethostname()
>  
>  try: serverSocket.bind((host, 0))
>  except socket.error as msg:
> -    print 'bind fails: ', msg
> +    print('bind fails: ' + str(msg))
>  
>  sn = serverSocket.getsockname()
>  serverPort = sn[1]
> @@ -51,10 +52,10 @@ serverPort = sn[1]
>  cmdStr = ("./tcp_client.py %d &") % (serverPort)
>  os.system(cmdStr)
>  
> -buf = ''
> +buf = b''
>  n = 0
>  while n < 500:
> -    buf += '.'
> +    buf += b'.'
>      n += 1
>  
>  serverSocket.listen(MAX_PORTS)
> @@ -79,5 +80,5 @@ while True:
>                  serverSocket.close()
>                  sys.exit(0)
>      else:
> -        print 'Select timeout!'
> +        print('Select timeout!')
>          sys.exit(1)
> 

