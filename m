Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F00C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B5E2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ahh7RzHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B5E2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbeKLRwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:52:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38468 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbeKLRwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:52:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id e3-v6so8178055wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 00:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=Fi3d1NwlxbWGA22YmQ1Zb+mX2YonQnBnO7Ll2p+rHBE=;
        b=ahh7RzHxb5BH3vWy/kFBgmM1FpXrBuAckL7gwjPO/jj/6diwMERNv8JPDCuzthyDQS
         LXuVIqE2CJsp/qvyTCG6CuwYRGkI8VL2QwbjdlIvakL/VISzMDtlFMGQHokqMkaH+0JJ
         nVXfbUVcqlPrfzK/XEr3I67/vTI459DDMmmqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=Fi3d1NwlxbWGA22YmQ1Zb+mX2YonQnBnO7Ll2p+rHBE=;
        b=ZKsfg57Iwy2tJ2D3vYIsakXJAHJYHgA8gAgw87GcFMDWgTpKJ7j8QrjYPWJq3lOuWB
         AiQWpL+B7CpElD4fEORTmbyGXHSerejmXVrWWD62Te7cy0ALJ6nx9gKIh371W6iOJzo2
         De1WbSBzAwEMgatxXoTNIwBlOTvmCFFSBW9j7/rqh+ExiV8kDk954w/2XgLGrfvnjZL8
         muXwWR31lthPK3JMbn9n8pniJPHAWsd27O+NvcVO3pYFa45eobdsNLFMwQYFZv9trJ3E
         1yfllL/m4OU4/Fg0EBAKB2DVFxJNxC9ZatIOnaeETCNrhG5fXLEiHFO0iEztgfX4ZIi6
         mzrQ==
X-Gm-Message-State: AGRZ1gLFD3rBuqdkB+eVkx5XUqBZsI2+Whwn7CBjsOUzxZXe36UxOFys
        XxB0XGU5ot3760WPEtCDvwuRWA==
X-Google-Smtp-Source: AJdET5ewzox8HHOFFK8srnapeYdll79qugUMl/SxM3LH+8J6wgcTHNynp7ScTqodMZDZpcVMjr44gA==
X-Received: by 2002:a5d:4512:: with SMTP id s18-v6mr15479924wrq.86.1542009600520;
        Mon, 12 Nov 2018 00:00:00 -0800 (PST)
Received: from [192.168.43.112] ([93.68.220.21])
        by smtp.gmail.com with ESMTPSA id y2-v6sm28299359wrh.53.2018.11.11.23.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 23:59:59 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: inconsistent IOPS and throughput for /dev/mdX (?)
Message-Id: <27E733A7-D003-4738-9AE9-728068416E56@linaro.org>
Date:   Mon, 12 Nov 2018 08:59:57 +0100
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Federico Motta <federico@willer.it>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org, Shaohua Li <shli@fb.com>,
        Mike Snitzer <snitzer@redhat.com>, Coly Li <colyli@suse.de>,
        Michael Lyle <mlyle@lyle.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Tang Junhui <tang.junhui.linux@gmail.com>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
the following command line

sudo fio --loops=3D20 --name=3Dseqreader -rw=3Dread --size=3D500M =
--numjobs=3D1 --filename=3D/dev/md0 & iostat -tmd /dev/md0 2 & sleep 15 =
; killall iostat

generates a sequence of lines like this one:

------------------

8.11.2018 14:08:351)][15.4%][r=3D444MiB/s][r=3D114k IOPS][eta 00m:22s]

Device             tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
md0            1313,50       811,52         0,00       1623          0

------------------

So, iostat says that the throughput is about twice as high as that
actually enjoyed by fio.

The device layout is

$ lsblk
NAME                MAJ:MIN RM   SIZE RO TYPE   MOUNTPOINT
sda                   8:0    0 119,2G  0 disk
=E2=94=9C=E2=94=80sda1                8:1    0   128M  0 part   =
/boot/EFI
=E2=94=94=E2=94=80sda2                8:2    0 119,1G  0 part
 =E2=94=94=E2=94=80md0               9:0    0 119,1G  0 raid10
   =E2=94=94=E2=94=80luks          253:0    0 119,1G  0 crypt
     =E2=94=9C=E2=94=80system-boot 253:1    0   512M  0 lvm    /boot
     =E2=94=9C=E2=94=80system-root 253:2    0 116,6G  0 lvm    /
     =E2=94=94=E2=94=80system-swap 253:3    0     2G  0 lvm    [SWAP]
sdb                   8:16   0 119,2G  0 disk
=E2=94=9C=E2=94=80sdb1                8:17   0   128M  0 part
=E2=94=94=E2=94=80sdb2                8:18   0 119,1G  0 part
 =E2=94=94=E2=94=80md0               9:0    0 119,1G  0 raid10
   =E2=94=94=E2=94=80luks          253:0    0 119,1G  0 crypt
     =E2=94=9C=E2=94=80system-boot 253:1    0   512M  0 lvm    /boot
     =E2=94=9C=E2=94=80system-root 253:2    0 116,6G  0 lvm    /
     =E2=94=94=E2=94=80system-swap 253:3    0     2G  0 lvm    [SWAP]

The cause of the apparently inconsistent output of iostat are the =
numbers in /proc/diskstats:

  8      16 sdb 14175 991 2671357 19399 699083 167975 42916330 1241832 =
0251020 694150 840537 0 42682016 157759
  8      17 sdb1 57 0 4696 16 0 0 0 0 0 20 20 0 0 0 0
  8      18 sdb2 14078 991 2663981 19351 684072 167975 42916330 1128887 =
0240580 686070 840537 0 42682016 157759
  8       0 sda 14156 1225 2653954 21037 699566 167483 42916331 1151504 =
0202610 596520 840546 0 42682016 129468
  8       1 sda1 214 168 7776 80 1 0 1 0 0 60 60 0 0 0 0
  8       2 sda2 13902 1057 2643498 20935 684554 167483 42916330 1039618 =
0198390 595160 840546 0 42682016 129468
  9       0 md0 29891 0 8836730 0 740295 0 46361824 0 0 0 0 842371 0 =
46963528 0
  8      32 sdc 260 228 10536 1053 0 0 0 0 0 670 670 0 0 0 0
  8      33 sdc1 210 228 7856 797 0 0 0 0 0 490 490 0 0 0 0
  8      48 sdd 276 180 9624 1027 0 0 0 0 0 690 690 0 0 0 0
  8      49 sdd1 226 180 6944 763 0 0 0 0 0 480 480 0 0 0 0
  9     127 md127 654 0 9120 0 0 0 0 0 0 0 0 0 0 0 0
253       0 dm-0 24390 0 5300378 58830 733400 0 42791400 37540750 0 =
1196370 37938570 821551 0 42682016 338170
253       1 dm-1 183 0 6714 120 13 0 72 70 0 170 190 0 0 0 0
253       2 dm-2 24071 0 5287400 58960 725884 0 42791336 37486510 0 =
1205100 37892450 821551 0 42682016 346660
253       3 dm-3 94 0 4936 160 0 0 0 0 0 160 160 0 0 0 0

(In addition, here is /sys/block/md0/stat:
  29892        0  8836762        0   741031        0 46403088        0   =
   0        0        0   843306        0 47004096        0)

Comparing the above numbers, we have

/dev/md0 : #read_io=3D29891 #sectors_read=3D8836730
/dev/sda2: #read_io=3D13902 #sectors_read=3D2643498
/dev/sdb2: #read_io=3D14078 #sectors_read=3D2663981

Is this a bug, or are we missing something?

Thanks,
Paolo

