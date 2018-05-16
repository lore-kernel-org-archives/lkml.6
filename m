Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752080AbeEPRdm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 13:33:42 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:39378 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbeEPRdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 13:33:40 -0400
X-Google-Smtp-Source: AB8JxZoDeAbvSnh/8R+YZd0i3RfKLeQsQpPl2RIEJU/DOldz+YZh3loe8RX7Jo4/b36MTPNHpAyWHg==
Subject: Re: INFO: task hung in blk_queue_enter
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzkaller-bugs@googlegroups.com
Cc: syzbot <syzbot+c4f9cebf9d651f6e54de@syzkaller.appspotmail.com>,
        linux-block@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, dvyukov@google.com,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Ming Lei <ming.lei@redhat.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
References: <0000000000009b212b056ae6dbad@google.com>
 <343bbbf6-64eb-879e-d19e-96aebb037d47@I-love.SAKURA.ne.jp>
 <b9c33b04-08d7-87a1-3d93-d81a84e6af12@I-love.SAKURA.ne.jp>
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Message-ID: <0609ee2b-fbb6-9122-918a-cc2172ee2cfa@gmail.com>
Date: Wed, 16 May 2018 18:33:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b9c33b04-08d7-87a1-3d93-d81a84e6af12@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > jbd2/sda1-8(PID=2271) is stuck waiting for journal commit operation.
 > I don't know how this thread is involved to this problem.

It feels like it should be a necessary link in the chain. This is the 
filesystem underneath the loop device. If that hangs, we would expect 
the loop device to hang, but not vice versa.

AIUI, you couldn't reproduce this hang on your own machine.

Don't you think, your fuzzer has just found a nice exploit for reiserfs?

Alan


(It's interesting that you found this hang just after we fixed 
block_queue_enter() to wait in D state instead of S state.[1]  I don't 
know syszkaller, so I assume from this it only flagged this case up 
because of the hung task warning. I.e. syzkaller didn't have its own 
watchdog that would have failed the test anyway.

[1] the commit that caused you to CC me. "block: do not use 
interruptible wait anywhere"

https://github.com/torvalds/linux/commit/1dc3039bc87ae7d19a990c3ee71cfd8a9068f428

)
