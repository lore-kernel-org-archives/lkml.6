Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DCEECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37D420856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZL08M6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37D420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388243AbeGWSfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:35:32 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44985 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388002AbeGWSfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:35:32 -0400
Received: by mail-oi0-f66.google.com with SMTP id s198-v6so2562819oih.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 10:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EzDRXJ95/mKl0U1X6L7KLiCwN7QB1YpPa1jwi5eCWjQ=;
        b=jZL08M6tFlDQSpQqmRRc7k2yazBd8701TsIdDcz9O5V0XbDmO3G6hKe1UQM0TqPybr
         Yn8nd+TvJZzOCaIfWsd3PzKPuYRdQtLIjElne3q0KIqNR/bUOWwPol1Jd8vniQM/k/mc
         UNigmIURTlF/b9QPtHuJaOqEhDyUghuMFuTqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EzDRXJ95/mKl0U1X6L7KLiCwN7QB1YpPa1jwi5eCWjQ=;
        b=FwSmeZwo0ESFzTSQhYoJ6fzS89L7MC9w2ImwW0ZvPW0nouO7ydmQBbrspr0CZZK0Ht
         9q9y0qxM/x3K3U6zc79vs/rvBc4UWNgJePvg34sDjJ/8CYcu1b4+hJbIl8Dfu/Z1L2g6
         iyN7x+69fH5Y/XYQFSTBGltuhvOnfxChiryUXb3W776t09z5GNLt+xY58d7Jw7JIzSSI
         1EjpOPdPdl66EWEJyFZFBjW+cx8Qw+5/inXcQ8BN0HRczd+NlbX94fR7BXYBOy0IaICn
         jLhhdt3QJEP325fttA5Iq2J1c9DCO7/mDmNGvJl8qU1IYHjr12/mbaAqMh2p9DePaKay
         e/4w==
X-Gm-Message-State: AOUpUlEEoBX3z6dsvQkqJyWUtCfXvNrE03fKBIh7EN+eHLsUHBx/O50E
        Rt4vKAgd4MQcoYqKTjtQy7N+cA==
X-Google-Smtp-Source: AAOMgpcQo80NFZnS28tGCiE6jm4gvVG3N9sL4nI5xpu5rSwreTMrGZNP+koAyfYg1MV6vyaXAkXMBg==
X-Received: by 2002:aca:da88:: with SMTP id r130-v6mr9645698oig.163.1532367195228;
        Mon, 23 Jul 2018 10:33:15 -0700 (PDT)
Received: from localhost ([2600:3c00::f03c:91ff:fefc:c793])
        by smtp.gmail.com with ESMTPSA id m62-v6sm25774933oik.30.2018.07.23.10.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 10:33:14 -0700 (PDT)
Date:   Mon, 23 Jul 2018 17:33:13 +0000
From:   Dan Rue <dan.rue@linaro.org>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Lawrence Brakmo <brakmo@fb.com>, jakub.kicinski@netronome.com
Subject: Re: [PATCH] bpf: Add Python 3 support to selftests scripts for bpf
Message-ID: <20180723173313.ri2uz7srtdtno2hl@linode.therub.org>
References: <20180718213610.19618-1-jcline@redhat.com>
 <1aa3dc98-2ab1-7386-d5d9-afd3dbb3fde9@iogearbox.net>
 <dd971e43-3148-5a54-788e-d89835d3638a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd971e43-3148-5a54-788e-d89835d3638a@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 10:08:57AM -0400, Jeremy Cline wrote:
> Hi Daniel,
> 
> On 07/20/2018 04:45 PM, Daniel Borkmann wrote:
> > On 07/18/2018 11:36 PM, Jeremy Cline wrote:
> >> Adjust tcp_client.py and tcp_server.py to work with Python 3 by using
> >> the print function, marking string literals as bytes, and using the
> >> newer exception syntax. This should be functionally equivalent and
> >> support Python 2.6 through Python 3.7.
> >>
> >> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> > 
> > Thanks for the patch, Jeremy! Given we also have test_offload.py in BPF
> > kselftests and it is written for python 3 only, it would probably make
> > sense to adapt the tcp_{client,server}.py towards python 3 as well, so
> > we wouldn't need to keep extra compat for 2 and have a consistent version
> > dependency. Lawrence / Jeremy, any objections?
> 
> I certainly don't object to Python 3 only and I'm happy to drop the
> Python 2 compatibility from this patch if that's okay.

This (well, along with introducing python in the first place, which took
me by surprise), sounds like a policy decision that should be made clear
in the kselftest documentation (Documentation/dev-tools/kselftest.rst).
Currently, that file does not mention any python requirement.

That said, I agree that python2 support is no longer necessary.

My use-case (which may be unusual?): We try to run all of kselftest
against a variety of kernels and architectures for every push to next,
mainline, and stable/lts branches. It seems that this is not a common
usecase, but shouldn't it be?

Dan

> 
> > 
> >>  tools/testing/selftests/bpf/tcp_client.py | 12 ++++++------
> >>  tools/testing/selftests/bpf/tcp_server.py | 17 +++++++++--------
> >>  2 files changed, 15 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/tcp_client.py b/tools/testing/selftests/bpf/tcp_client.py
> >> index 481dccdf140c..9fe5f1b5c020 100755
> >> --- a/tools/testing/selftests/bpf/tcp_client.py
> >> +++ b/tools/testing/selftests/bpf/tcp_client.py
> >> @@ -1,4 +1,4 @@
> >> -#!/usr/bin/env python2
> >> +#!/usr/bin/env python
> >>  #
> >>  # SPDX-License-Identifier: GPL-2.0
> >>  #
> >> @@ -9,11 +9,11 @@ import subprocess
> >>  import select
> >>  
> >>  def read(sock, n):
> >> -    buf = ''
> >> +    buf = b''
> >>      while len(buf) < n:
> >>          rem = n - len(buf)
> >>          try: s = sock.recv(rem)
> >> -        except (socket.error), e: return ''
> >> +        except (socket.error) as e: return b''
> >>          buf += s
> >>      return buf
> >>  
> >> @@ -22,7 +22,7 @@ def send(sock, s):
> >>      count = 0
> >>      while count < total:
> >>          try: n = sock.send(s)
> >> -        except (socket.error), e: n = 0
> >> +        except (socket.error) as e: n = 0
> >>          if n == 0:
> >>              return count;
> >>          count += n
> >> @@ -39,10 +39,10 @@ try:
> >>  except socket.error as e:
> >>      sys.exit(1)
> >>  
> >> -buf = ''
> >> +buf = b''
> >>  n = 0
> >>  while n < 1000:
> >> -    buf += '+'
> >> +    buf += b'+'
> >>      n += 1
> >>  
> >>  sock.settimeout(1);
> >> diff --git a/tools/testing/selftests/bpf/tcp_server.py b/tools/testing/selftests/bpf/tcp_server.py
> >> index bc454d7d0be2..1d4a40a6584b 100755
> >> --- a/tools/testing/selftests/bpf/tcp_server.py
> >> +++ b/tools/testing/selftests/bpf/tcp_server.py
> >> @@ -1,7 +1,8 @@
> >> -#!/usr/bin/env python2
> >> +#!/usr/bin/env python
> >>  #
> >>  # SPDX-License-Identifier: GPL-2.0
> >>  #
> >> +from __future__ import print_function
> >>  
> >>  import sys, os, os.path, getopt
> >>  import socket, time
> >> @@ -9,11 +10,11 @@ import subprocess
> >>  import select
> >>  
> >>  def read(sock, n):
> >> -    buf = ''
> >> +    buf = b''
> >>      while len(buf) < n:
> >>          rem = n - len(buf)
> >>          try: s = sock.recv(rem)
> >> -        except (socket.error), e: return ''
> >> +        except (socket.error) as e: return b''
> >>          buf += s
> >>      return buf
> >>  
> >> @@ -22,7 +23,7 @@ def send(sock, s):
> >>      count = 0
> >>      while count < total:
> >>          try: n = sock.send(s)
> >> -        except (socket.error), e: n = 0
> >> +        except (socket.error) as e: n = 0
> >>          if n == 0:
> >>              return count;
> >>          count += n
> >> @@ -43,7 +44,7 @@ host = socket.gethostname()
> >>  
> >>  try: serverSocket.bind((host, 0))
> >>  except socket.error as msg:
> >> -    print 'bind fails: ', msg
> >> +    print('bind fails: ' + str(msg))
> >>  
> >>  sn = serverSocket.getsockname()
> >>  serverPort = sn[1]
> >> @@ -51,10 +52,10 @@ serverPort = sn[1]
> >>  cmdStr = ("./tcp_client.py %d &") % (serverPort)
> >>  os.system(cmdStr)
> >>  
> >> -buf = ''
> >> +buf = b''
> >>  n = 0
> >>  while n < 500:
> >> -    buf += '.'
> >> +    buf += b'.'
> >>      n += 1
> >>  
> >>  serverSocket.listen(MAX_PORTS)
> >> @@ -79,5 +80,5 @@ while True:
> >>                  serverSocket.close()
> >>                  sys.exit(0)
> >>      else:
> >> -        print 'Select timeout!'
> >> +        print('Select timeout!')
> >>          sys.exit(1)
> >>
> > 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kselftest" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
