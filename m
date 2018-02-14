Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967742AbeBNNCv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:02:51 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36866 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967589AbeBNNCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:02:49 -0500
X-Google-Smtp-Source: AH8x2250gUI4fXwFOim7CaetOMZaHJPR+t9iDbCZW+aQlDreOmRtSOOh+NEyyqYPCNAAVTavYumkDg==
To: NeilBrown <neilb@suse.com>, Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Milan Broz <gmazyland@gmail.com>
Subject: DM Regression in 4.16-rc1 - read() returns data when it shouldn't
Message-ID: <70cda2a3-f246-d45b-f600-1f9d15ba22ff@gmail.com>
Date: Wed, 14 Feb 2018 14:02:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
 Thunderbird/31.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the commit (found by bisect)

  commit 18a25da84354c6bb655320de6072c00eda6eb602
  Author: NeilBrown <neilb@suse.com>
  Date:   Wed Sep 6 09:43:28 2017 +1000

    dm: ensure bio submission follows a depth-first tree walk

cause serious regression while reading from DM device.

The reproducer is below, basically it tries to simulate failure we see in cryptsetup
regression test: we have DM device with error and zero target and try to read
"passphrase" from it (it is test for 64 bit offset error path):

Test device:
# dmsetup table test
0 10000000 error 
10000000 1000000 zero 

We try to run this operation:
  lseek64(fd, 5119999988, SEEK_CUR); // this should seek to error target sector
  read(fd, buf, 13); // this should fail, if we seek to error part of the device

While on 4.15 the read properly fails:
  Seek returned 5119999988.
  Read returned -1.

for 4.16 it actually succeeds returning some random data
(perhaps kernel memory, so this bug is even more dangerous):
  Seek returned 5119999988.
  Read returned 13.

Full reproducer below:

#define _GNU_SOURCE
#define _LARGEFILE64_SOURCE
#include <stdio.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <inttypes.h>

int main (int argc, char *argv[])
{
        char buf[13];
        int fd;
        //uint64_t offset64 = 5119999999;
        uint64_t offset64 =   5119999988;
        off64_t r;
        ssize_t bytes;

        system("echo -e \'0 10000000 error\'\\\\n\'10000000 1000000 zero\' | dmsetup create test");

        fd = open("/dev/mapper/test", O_RDONLY);
        if (fd == -1) {
                printf("open fail\n");
                return 1;
        }

        r = lseek64(fd, offset64, SEEK_CUR);
        printf("Seek returned %" PRIu64 ".\n", r);
        if (r < 0) {
                printf("seek fail\n");
                close(fd);
                return 2;
        }

        bytes = read(fd, buf, 13);
        printf("Read returned %d.\n", (int)bytes);

        close(fd);
        return 0;
}


Please let me know if you need more info to reproduce it.

Milan
