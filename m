Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA10C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3979E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP1W2ET8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3979E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbeIJWYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbeIJWYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:24:16 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3873C20645;
        Mon, 10 Sep 2018 17:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536600547;
        bh=usd3bJ6sMIDy3b88vRpMe67TKQhE0xbh5TvZxtPKUaU=;
        h=Date:From:To:Cc:Subject:From;
        b=FP1W2ET8RKMm9nE3S9LFGiGv7lSiVZzDx3NsoeRAxYxZbPdKNzoQcYq8QzgxOfFHB
         NO1DpLl946p2HpM1QHfq2PR7xH8t15hPrgu8SyOuNKB0pOiFl00XC9tqPGCyMTWMi7
         /0JKSJQPJ1Q1CIMZBjVf+4evOiZXnBd3Ur0Dtfhk=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 5791C143C7B; Mon, 10 Sep 2018 14:29:03 -0300 (-03)
Date:   Mon, 10 Sep 2018 14:29:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking Development Mailing List 
        <netdev@vger.kernel.org>
Subject: libbpf build broken on musl libc (Alpine Linux)
Message-ID: <20180910172903.GB15516@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

	Ingo updated tip/perf/core and this made me notice that perf is
not building on systems using !glibc, like Alpine Linux, that uses musl
libc. This ends up as:

  # dm
   1 alpine:3.4                    : FAIL gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : FAIL gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : FAIL gcc (Alpine 6.3.0) 6.3.0
   4 alpine:3.7                    : FAIL gcc (Alpine 6.4.0) 6.4.0
   5 alpine:3.8                    : FAIL gcc (Alpine 6.4.0) 6.4.0
   6 alpine:edge                   : FAIL gcc (Alpine 6.4.0) 6.4.0
   7 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
   8 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5)
   9 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  10 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  11 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  12 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  13 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-28)
  14 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  15 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u1) 4.9.2
  17 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
  18 debian:experimental           : Ok   gcc (Debian 8.2.0-4) 8.2.0
<still building on the other containers, 65 in total>

  CC       /tmp/build/perf/libbpf.o
  CC       /tmp/build/perf/event-plugin.o
  CC       /tmp/build/perf/parse-options.o
libbpf.c: In function 'bpf_object__elf_init':
libbpf.c:472:15: error: initialization makes pointer from integer without a cast [-Werror=int-conversion]
    char *cp = strerror_r(errno, errmsg, sizeof(errmsg));
               ^
libbpf.c: In function 'bpf_object__elf_collect':
libbpf.c:813:16: error: initialization makes pointer from integer without a cast [-Werror=int-conversion]
     char *cp = strerror_r(-err, errmsg,
                ^
libbpf.c: In function 'bpf_object__create_maps':
libbpf.c:1143:7: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
    cp = strerror_r(errno, errmsg, sizeof(errmsg));
       ^
libbpf.c:1158:7: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
    cp = strerror_r(errno, errmsg, sizeof(errmsg));
       ^
libbpf.c: In function 'load_program':
libbpf.c:1342:5: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
  cp = strerror_r(errno, errmsg, sizeof(errmsg));
     ^
libbpf.c: In function 'check_path':
libbpf.c:1657:6: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
   cp = strerror_r(errno, errmsg, sizeof(errmsg));
      ^
libbpf.c: In function 'bpf_program__pin_instance':
libbpf.c:1693:6: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
   cp = strerror_r(errno, errmsg, sizeof(errmsg));
      ^
libbpf.c: In function 'make_dir':
libbpf.c:1711:6: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
   cp = strerror_r(-err, errmsg, sizeof(errmsg));
      ^
libbpf.c: In function 'bpf_map__pin':
libbpf.c:1773:6: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
   cp = strerror_r(errno, errmsg, sizeof(errmsg));
      ^
  CC       /tmp/build/perf/trace-seq.o
  CC       /tmp/build/perf/parse-filter.o
  CC       /tmp/build/perf/parse-utils.o
cc1: all warnings being treated as errors
mv: can't rename '/tmp/build/perf/.libbpf.o.tmp': No such file or directory

This is handled in tools/perf/ by using tools/lib/str_error_r.c, that
was introduced with the cset at the end of this message.

After lunch I'll work on a patch to fix this, 

Thanks,

- Arnaldo

commit c8b5f2c96d1bf6cefcbe12f67dce0b892fe20512
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Wed Jul 6 11:56:20 2016 -0300

    tools: Introduce str_error_r()
    
    The tools so far have been using the strerror_r() GNU variant, that
    returns a string, be it the buffer passed or something else.
    
    But that, besides being tricky in cases where we expect that the
    function using strerror_r() returns the error formatted in a provided
    buffer (we have to check if it returned something else and copy that
    instead), breaks the build on systems not using glibc, like Alpine
    Linux, where musl libc is used.
    
    So, introduce yet another wrapper, str_error_r(), that has the GNU
    interface, but uses the portable XSI variant of strerror_r(), so that
    users rest asured that the provided buffer is used and it is what is
    returned.
    
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Wang Nan <wangnan0@huawei.com>
    Link: http://lkml.kernel.org/n/tip-d4t42fnf48ytlk8rjxs822tf@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index e26223f1f287..b466d0228b57 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -12,4 +12,6 @@ int strtobool(const char *s, bool *res);
 extern size_t strlcpy(char *dest, const char *src, size_t size);
 #endif
 
+char *str_error_r(int errnum, char *buf, size_t buflen);
<SNIP>
