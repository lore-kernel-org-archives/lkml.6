Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE14DC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC94262E2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC94262E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933915AbeFYX6c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:58:32 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:39354 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754330AbeFYX6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:58:30 -0400
Received: by mail-oi0-f50.google.com with SMTP id 18-v6so4752053oiq.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 16:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=T6M1Ea2lWkKI1m2JpBOt5Tj3Hp17bPAid1z2zbwPNFo=;
        b=e9SALJMUdA0jVt7+iu8VPX7SiKeFBAtuxOBQHaigljkB/CTQVrK2vLlXnrQYtcjArA
         +L3OrhOXQiiGqeY5jTKWGxn9cJ9U+AWXkjMB4wXIALq3cA7oJhpS8SwYF5iX++lB7+iK
         pcZBYcRUiERD9v3W5wL8ETAC5u6yMvCdpltuXMiPZlKXW13spvm/JMGTrrGr1OPQ7L6O
         i8GlVrbE8CybQSBLhSS63QAfzoEA22TAqvFR5ihMIUeVEhtVVHrViqFY7bK2vcL8n/FL
         bQbl1EtPs4AtT36D8VWe3cPqqb8UCo2QiQb4wzvgDwdYsYcsX+L4HYDAkaGx/2etennZ
         qG3g==
X-Gm-Message-State: APt69E133jfQ93kTfkFzjUMSZEV/UCzd55gKt50K9YLuc//6FE/FOeAb
        vMZbi2J5f0z24vCWO/kAvvZ/xA==
X-Google-Smtp-Source: ADUXVKLYGtdgb/l1dtn1Y0J4DhjLDhqWGyrrtDNEsDqdAiXZ+jOWZT/Dibz4z9tyu8R3g6zOq1oS1A==
X-Received: by 2002:aca:66db:: with SMTP id m88-v6mr355297oik.141.1529971109497;
        Mon, 25 Jun 2018 16:58:29 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::f0c1? ([2601:602:9802:a8dc::f0c1])
        by smtp.gmail.com with ESMTPSA id 5-v6sm103100oid.50.2018.06.25.16.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 16:58:28 -0700 (PDT)
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org
Cc:     samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        Adam Williamson <awilliam@redhat.com>
From:   Laura Abbott <labbott@redhat.com>
Subject: F_OFD_GETLK implemented wrong with CIFS protocol version 2.0+
Message-ID: <77967693-040b-734a-8e18-be95d97478b3@redhat.com>
Date:   Mon, 25 Jun 2018 16:58:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A while back, someone reported a failure on Fedora when trying to boot
a QEMU image off of a CIFS share. The issue was reduced down to a
test case (https://bugzilla.redhat.com/show_bug.cgi?id=1484130#c8)

# cat test-ofd-lock.c
#define _GNU_SOURCE
#include <errno.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main(int argc, char **argv)
{
     int ret;
     int fd;
     struct flock fl = {
         .l_whence = SEEK_SET,
         .l_start  = 0,
         .l_len    = 0,
         .l_type   = F_RDLCK,
     };
     if (argc < 2) {
             fprintf(stderr, "Usage: %s <file>\n", argv[0]);
             return 1;
     }
     fd = open(argv[1], O_RDWR);
     if (fd < 0) {
             perror("open");
             return errno;
     }
     ret = fcntl(fd, F_OFD_SETLK, &fl);
     if (ret) {
             perror("setlk");
             return errno;
     }
     fl.l_type = F_WRLCK;
     ret = fcntl(fd, F_OFD_GETLK, &fl);
     if (ret) {
             perror("getlk");
             return errno;
     }
     if (fl.l_type != F_UNLCK) {
             fprintf(stderr, "get lock test failed\n");
             return 1;
     }
     return 0;
}
[root@localhost ~]# make test-ofd-lock
cc     test-ofd-lock.c   -o test-ofd-lock
[root@localhost ~]# touch /tmp/test && ./test-ofd-lock /tmp/test
[root@localhost ~]# echo $?
0
[root@localhost ~]# touch /mnt/test && ./test-ofd-lock /mnt/test
get lock test failed
[root@localhost ~]# mount | grep /mnt
//192.168.31.1/tddownload on /mnt type cifs (rw,relatime,vers=3.0,
cache=strict,username=admin,domain=,uid=0,
noforceuid,gid=0,noforcegid,addr=192.168.31.1,file_mode=0755,
dir_mode=0755,nounix,serverino,mapposix,rsize=1048576,
wsize=1048576,echo_interval=60,actimeo=1,user=admin)


As explained by one of the QEMU developers
(https://bugzilla.redhat.com/show_bug.cgi?id=1484130#c37)

'''
It is a kernel bug. The code snippet in comment 8 shows clearly that the kernel
is doing the wrong thing, which cannot be fixed/worked around by QEMU.

In man 2 fcntl:

        F_OFD_GETLK (struct flock *)
               On input to this call, lock describes an open file description lock
we would like to place on the file.  If the lock could  be  placed,  fcntl()  does  not
               actually  place  it,  but  returns F_UNLCK in the l_type field of lock
and leaves the other fields of the structure unchanged.  If one or more incompatible
               locks would prevent this lock being placed, then details about one of
these locks are returned via lock, as described above for F_GETLK.

which is not the case with the new CIFS behaviour.
''

You can read the full context at https://bugzilla.redhat.com/show_bug.cgi?id=1484130

Any suggestions?

Thanks,
Laura
