Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB26C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2F422EC0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2F422EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934639AbeF0BLn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:11:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933723AbeF0BLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:11:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCF1D308FB8E;
        Wed, 27 Jun 2018 01:11:41 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A83CC7A04C;
        Wed, 27 Jun 2018 01:11:41 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 886171800B68;
        Wed, 27 Jun 2018 01:11:41 +0000 (UTC)
Date:   Tue, 26 Jun 2018 21:11:40 -0400 (EDT)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     labbott@redhat.com, CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Williamson <awilliam@redhat.com>
Message-ID: <1332132554.10805313.1530061900159.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAH2r5muV49o7aTco1757UwuW-c6Fn5r=EW3QMCMfU7FFLZNMTw@mail.gmail.com>
References: <77967693-040b-734a-8e18-be95d97478b3@redhat.com> <CAH2r5muV49o7aTco1757UwuW-c6Fn5r=EW3QMCMfU7FFLZNMTw@mail.gmail.com>
Subject: Re: F_OFD_GETLK implemented wrong with CIFS protocol version 2.0+
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.64.54.105, 10.4.195.14]
Thread-Topic: F_OFD_GETLK implemented wrong with CIFS protocol version 2.0+
Thread-Index: cyUI5gdk5jnau9xZqprq5PrbDI0PLw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 27 Jun 2018 01:11:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is in fs/cifs/file.c:cifs_find_fid_lock_conflict since it is not aware of OFD locks
and thus think there is a conflict.

I have an initial patch that fixes the problem for the reproducer but need more time to understand if/what
else might need fixin.





----- Original Message -----
> From: "Steve French" <smfrench@gmail.com>
> To: labbott@redhat.com
> Cc: "CIFS" <linux-cifs@vger.kernel.org>, "samba-technical" <samba-technical@lists.samba.org>, "LKML"
> <linux-kernel@vger.kernel.org>, "Adam Williamson" <awilliam@redhat.com>
> Sent: Tuesday, 26 June, 2018 1:54:40 PM
> Subject: Re: F_OFD_GETLK implemented wrong with CIFS protocol version 2.0+
> 
> We are taking a look at this - Ronnie had some ideas.  Probably simply
> not implemented - hopefully not too hard to fix.
> On Mon, Jun 25, 2018 at 6:58 PM Laura Abbott <labbott@redhat.com> wrote:
> >
> > Hi,
> >
> > A while back, someone reported a failure on Fedora when trying to boot
> > a QEMU image off of a CIFS share. The issue was reduced down to a
> > test case (https://bugzilla.redhat.com/show_bug.cgi?id=1484130#c8)
> >
> > # cat test-ofd-lock.c
> > #define _GNU_SOURCE
> > #include <errno.h>
> > #include <stdio.h>
> > #include <unistd.h>
> > #include <fcntl.h>
> >
> > int main(int argc, char **argv)
> > {
> >      int ret;
> >      int fd;
> >      struct flock fl = {
> >          .l_whence = SEEK_SET,
> >          .l_start  = 0,
> >          .l_len    = 0,
> >          .l_type   = F_RDLCK,
> >      };
> >      if (argc < 2) {
> >              fprintf(stderr, "Usage: %s <file>\n", argv[0]);
> >              return 1;
> >      }
> >      fd = open(argv[1], O_RDWR);
> >      if (fd < 0) {
> >              perror("open");
> >              return errno;
> >      }
> >      ret = fcntl(fd, F_OFD_SETLK, &fl);
> >      if (ret) {
> >              perror("setlk");
> >              return errno;
> >      }
> >      fl.l_type = F_WRLCK;
> >      ret = fcntl(fd, F_OFD_GETLK, &fl);
> >      if (ret) {
> >              perror("getlk");
> >              return errno;
> >      }
> >      if (fl.l_type != F_UNLCK) {
> >              fprintf(stderr, "get lock test failed\n");
> >              return 1;
> >      }
> >      return 0;
> > }
> > [root@localhost ~]# make test-ofd-lock
> > cc     test-ofd-lock.c   -o test-ofd-lock
> > [root@localhost ~]# touch /tmp/test && ./test-ofd-lock /tmp/test
> > [root@localhost ~]# echo $?
> > 0
> > [root@localhost ~]# touch /mnt/test && ./test-ofd-lock /mnt/test
> > get lock test failed
> > [root@localhost ~]# mount | grep /mnt
> > //192.168.31.1/tddownload on /mnt type cifs (rw,relatime,vers=3.0,
> > cache=strict,username=admin,domain=,uid=0,
> > noforceuid,gid=0,noforcegid,addr=192.168.31.1,file_mode=0755,
> > dir_mode=0755,nounix,serverino,mapposix,rsize=1048576,
> > wsize=1048576,echo_interval=60,actimeo=1,user=admin)
> >
> >
> > As explained by one of the QEMU developers
> > (https://bugzilla.redhat.com/show_bug.cgi?id=1484130#c37)
> >
> > '''
> > It is a kernel bug. The code snippet in comment 8 shows clearly that the
> > kernel
> > is doing the wrong thing, which cannot be fixed/worked around by QEMU.
> >
> > In man 2 fcntl:
> >
> >         F_OFD_GETLK (struct flock *)
> >                On input to this call, lock describes an open file
> >                description lock
> > we would like to place on the file.  If the lock could  be  placed,
> > fcntl()  does  not
> >                actually  place  it,  but  returns F_UNLCK in the l_type
> >                field of lock
> > and leaves the other fields of the structure unchanged.  If one or more
> > incompatible
> >                locks would prevent this lock being placed, then details
> >                about one of
> > these locks are returned via lock, as described above for F_GETLK.
> >
> > which is not the case with the new CIFS behaviour.
> > ''
> >
> > You can read the full context at
> > https://bugzilla.redhat.com/show_bug.cgi?id=1484130
> >
> > Any suggestions?
> >
> > Thanks,
> > Laura
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-cifs" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> --
> Thanks,
> 
> Steve
> --
> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
