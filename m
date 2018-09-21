Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F628C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FD82154B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 08:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=percona.com header.i=@percona.com header.b="YK889Ti0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46FD82154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=percona.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbeIUOEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 10:04:54 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:37595 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388909AbeIUOEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 10:04:53 -0400
Received: by mail-wr1-f50.google.com with SMTP id u12-v6so11923154wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 01:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=percona.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=cy2E0BJJNO6YKN2PQbDR8Z6ENHt/fAXt3XAor1jAo44=;
        b=YK889Ti0APsCSUwS/dhXq0VoQRdWwR2zkYjBB7GG5EUIrOycYINFiBzJQXCPstSeSU
         4VcCUbfMmdGtuB9ZUfR/jmTTx+xmNkJmwLutxFZy4vcKu+mk1j70AuozTSZfLoMe+Knj
         SoscP4AKAD3XuW3qtYCLQ7f3PvoCCRrzz0OeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cy2E0BJJNO6YKN2PQbDR8Z6ENHt/fAXt3XAor1jAo44=;
        b=RaAyN/Fx70ANLUlv0doKvADaNoh2iQl7mBmBEQ0EQTmBekflnR/2Onnl8cmkl4llm1
         AjmSxBY3HJJBOeXEnSKTgI8J0PnkMMQdHzOp6aJ+MPvRiZM/VepXoya75Y1enLoDWM2U
         hilGUzQMB8VnVqMjQVhhczUPumIf8KUcU9MsZbZXJjprrQCLFADC0gTD34ZMer5cx82z
         Ord99FU/IrULEjTLCO9f0XtELKDwkxoyZgjPiSJ9a0GZdO2R0P6NC9lZsyHuTs98jLtt
         GT4KjR25r8X+MXmZ8rhSi3RQw1gWpWFQUzXh/4o/g/8x+odAeqXYUnO9dIkcWL3phICt
         1X4g==
X-Gm-Message-State: APzg51C9p6sBE8mh8nO2vyob85s6LwU22+vLpgelIkPdJVs6+4I60a0P
        XERJYRbbKNndfQzygd7bPsr3G4m4MFiLEAxK723K4XFdUjFEog==
X-Google-Smtp-Source: ANB0Vda8U2QjE/V9oT6ZW1GxA6sNjKt6a2wSvxloK6ccpEUh3eqxZz3nzNwY38Z+yHICcasyvrFQp5326g6lKc8L47k=
X-Received: by 2002:a5d:68c9:: with SMTP id p9-v6mr36980440wrw.108.1537517827097;
 Fri, 21 Sep 2018 01:17:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:57cc:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 01:16:26
 -0700 (PDT)
From:   Roel Van de Paar <roel.vandepaar@percona.com>
Date:   Fri, 21 Sep 2018 18:16:26 +1000
Message-ID: <CAGQTitMPcrHRhFVLfApe21T7hYyeX05ffuSJj452+f+ZksmQqg@mail.gmail.com>
Subject: Bug: getcwd: cannot access parent directories
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

"cd: error retrieving current directory: getcwd: cannot access parent
directories: No such file or directory" on move of directories to
another volume

[2.] Full description of the problem/report:

Example output (testcase below):

/tmp/1/2$ cd ..
cd: error retrieving current directory: getcwd: cannot access parent
directories: No such file or directory
/tmp/1/2/..$ cd ..
cd: error retrieving current directory: getcwd: cannot access parent
directories: No such file or directory
/tmp/1/2/../..$ cd ..
cd: error retrieving current directory: getcwd: cannot access parent
directories: No such file or directory
/tmp/1/2/../../..$ cd ..
cd: error retrieving current directory: getcwd: cannot access parent
directories: No such file or directory
/tmp/1/2/../../../..$ cd ..
cd: error retrieving current directory: getcwd: cannot access parent
directories: No such file or directory
/tmp/1/2/../../../../..$ cd ..
cd: error retrieving current directory: getcwd: cannot access parent
directories: No such file or directory
/tmp/1/2/../../../../../..$ cd ..
/tmp$

- The number of ".." required is not correct
- The number of ".." matches the number of subdirs (see below)

[4.] Kernel information

Tested on latest updates of:
* Ubuntu Xenial
* Ubuntu Bionic
* Centos 7

[7.] A small shell script or example program which triggers the
problem (if possible)

In session 1
  cd /tmp
  mkdir -p 1/2
  cd 1/2

In session 2 (another terminal session)
  cd /tmp
  mkdir -p 3/4/5/6/7
  mv 1 3/4/5/6/7
  mv 3 /dev/shm   # where /dev/shm is some other disk. /dev/shm
reproduction works too. If the disk is the same, the issue will not
show.

Back to session 1
  cd ..   # fail
  cd ..   # fail
  cd ..   # fail
  cd ..   # fail
  cd ..   # fail
  cd ..   # fail
  cd ..   # works, but to completely incorrect directory given the
many 'cd ..'```

The problem is made more clear here by using 3/4/5/6/7 but you can
also just use a single subdir to see it
