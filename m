Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753898AbeDWBaR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 21:30:17 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:44420 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753821AbeDWBaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 21:30:13 -0400
X-Google-Smtp-Source: AB8JxZpNt8RsaJnRht+QuUFLMoxUE2RkUsV5kEA8kRLno1EWGidl3FkG1pHqN++KdlSOAeYVmz2LsvC1aiQ5n40CBK0=
MIME-Version: 1.0
Reply-To: robert@ocallahan.org
From: "Robert O'Callahan" <robert@ocallahan.org>
Date: Mon, 23 Apr 2018 13:30:11 +1200
X-Google-Sender-Auth: oOtJoOlclyW_nz5MZyGKLnT2rzU
Message-ID: <CAOp6jLboYSFC+Ms4Bo9PxNB3hpEBhEXwiuBAoe=xBoDMa810yQ@mail.gmail.com>
Subject: regression in 32-bit-compat dev_ioctl due to commit bf4405737f9f85a06db2b0ce5d76a818b61992e2
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit says

    Once upon a time net/socket.c:dev_ifsioc() used to handle SIOCSHWTSTAMP and
    SIOCSIFMAP.  These have different native and compat layout, so the format
    conversion had been needed.  In 2009 these two cases had been taken out,
    turning the rest into a convoluted way to calling sock_do_ioctl().  We copy
    compat structure into native one, call sock_do_ioctl() on that and copy
    the result back for the in/out ioctls.  No layout transformation anywhere,
    so we might as well just call sock_do_ioctl() and skip all the headache with
    copying.

However there is one problem: 32-bit 'struct ifreq' and 64-bit 'struct
ifreq' are not the same size. The former is 32 bytes and the latter is
40 bytes. Thus, if you place a 32-bit 'struct ifreq' immediately
before an unmapped page and try to pass it to one of these ioctls, the
syscall fails with EFAULT due to this commit.

More details including test program in
https://bugzilla.kernel.org/show_bug.cgi?id=199469.

I found this bug running the rr test suite.

Thanks,
Rob
-- 
Su ot deraeppa sah dna Rehtaf eht htiw saw hcihw, efil lanrete eht uoy
ot mialcorp ew dna, ti ot yfitset dna ti nees evah ew; deraeppa efil
eht. Efil fo Drow eht gninrecnoc mialcorp ew siht - dehcuot evah sdnah
ruo dna ta dekool evah ew hcihw, seye ruo htiw nees evah ew hcihw,
draeh evah ew hcihw, gninnigeb eht morf saw hcihw taht.
