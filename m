Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeEVPRZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:17:25 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:64098 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbeEVPQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:16:58 -0400
From: Faiz Abbas <faiz_abbas@ti.com>
Subject: mmc filesystem performance decreased on the first write after
 filesystem creation
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Message-ID: <a976e20a-3ed1-43d0-4665-f570ef496d02@ti.com>
Date: Tue, 22 May 2018 20:48:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am debugging a performance reduction in ext2 filesystems on an mmc
device in TI's am335x evm board.

I see that the performance is reduced on the first write after making a
new filesystem using mkfs.ext2 on one of the mmc partitions. The
performance comes back to normal after the first write.

commands used:

=> umount /dev/mmcblk1p2

=> mkfs.ext2 -F  /dev/mmcblk1p2

=> mount -t ext2 -o async /dev/mmcblk1p2 /mnt/partition_mmc

=> dd if=/dev/urandom of=/dev/shm/srctest_file_mmc_1184 bs=1M count=10

=> ./filesystem_tests -write -src_file /dev/shm/srctest_file_mmc_1184
-srcfile_size 10 -file /mnt/partition_mmc/test_file_1184 -buffer_size
102400 -file_size 100 -performance

The filesystem_tests write utility reads from the file generated at
/dev/shm/srctest_file_mmc_1184, memory maps the file to a buffer, and
then writes it into the newly created /mnt/partition_mmc in multiples of
buffer_size while measuring write performance.

See here for the implementation of filesystem_tests write utility:
http://arago-project.org/git/projects/?p=test-automation/ltp-ddt.git;a=blob;f=testcases/ddt/filesystem_test_suite/src/testcases/st_filesystem_write_to_file.c;h=80e8e244d7eaa9f0dbd9b21ea705445156c36bef;hb=f7fc06c290333ce08a7d4fba104eee0f0f1d942b

Complete log with multiple calls to filesystem_tests:
https://pastebin.ubuntu.com/p/BckmTJpqPv/

Notice that the first run of filesystem_tests has a lower throughput
reported.

I was able to bisect the issue to this commit:
5d1429fead5b (mmc: remove the discard_zeroes_data flag)

I would assume that after this flag is removed, the filesystem creation
command would explicitly write zeroes to the device which might explain
the performance fall. However, then the mkfs.ext2 command itself should
take more time rather than the first file write after that.

It would be nice if someone could help me understand why this is happening.

Thanks for your help.

Regards,
Faiz
