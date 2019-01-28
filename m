Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C8EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB1E21736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfA1JSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:18:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:58664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbfA1JSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:18:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02A65AD69;
        Mon, 28 Jan 2019 09:18:29 +0000 (UTC)
Subject: Re: [linux-next] kcompactd0 stuck in a CPU-burning loop
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <20190128085747.GA14454@jagdpanzerIV>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Message-ID: <5e98c5e9-9a8a-70db-c991-a5ca9c501e83@suse.cz>
Date:   Mon, 28 Jan 2019 10:18:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190128085747.GA14454@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/19 9:57 AM, Sergey Senozhatsky wrote:
> Hello,
> 
> next-20190125
> 
> kcompactd0 is spinning on something, burning CPUs in the meantime:

Hi, could you check/add this to the earlier thread? Thanks.

https://lore.kernel.org/lkml/20190126200005.GB27513@amd/T/#u

> 
>  %CPU         TIME+      COMMAND
>  100.0   0.0  34:04.20 R [kcompactd0]
> 
> Not sure I know how to reproduce it; so am probably not going to
> be a very helpful tester.
> 
> I tried to ftrace kcompactd0 PID, and I see the same path all over
> the tracing file:
> 
>  2)   0.119 us    |    unlock_page();
>  2)   0.109 us    |    unlock_page();
>  2)   0.096 us    |    compaction_free();
>  2)   0.104 us    |    ___might_sleep();
>  2)   0.121 us    |    compaction_alloc();
>  2)   0.111 us    |    page_mapped();
>  2)   0.105 us    |    page_mapped();
>  2)               |    move_to_new_page() {
>  2)   0.102 us    |      page_mapping();
>  2)               |      buffer_migrate_page_norefs() {
>  2)               |        __buffer_migrate_page() {
>  2)               |          expected_page_refs() {
>  2)   0.118 us    |            page_mapping();
>  2)   0.321 us    |          }
>  2)               |          __might_sleep() {
>  2)   0.122 us    |            ___might_sleep();
>  2)   0.332 us    |          }
>  2)               |          _raw_spin_lock() {
>  2)   0.115 us    |            preempt_count_add();
>  2)   0.321 us    |          }
>  2)               |          _raw_spin_unlock() {
>  2)   0.114 us    |            preempt_count_sub();
>  2)   0.321 us    |          }
>  2)               |          invalidate_bh_lrus() {
>  2)               |            on_each_cpu_cond() {
>  2)               |              on_each_cpu_cond_mask() {
>  2)               |                __might_sleep() {
>  2)   0.114 us    |                  ___might_sleep();
>  2)   0.316 us    |                }
>  2)   0.109 us    |                preempt_count_add();
>  2)   0.128 us    |                has_bh_in_lru();
>  2)   0.105 us    |                has_bh_in_lru();
>  2)   0.124 us    |                has_bh_in_lru();
>  2)   0.103 us    |                has_bh_in_lru();
>  2)   0.125 us    |                has_bh_in_lru();
>  2)   0.105 us    |                has_bh_in_lru();
>  2)   0.123 us    |                has_bh_in_lru();
>  2)   0.107 us    |                has_bh_in_lru();
>  2)               |                on_each_cpu_mask() {
>  2)   0.104 us    |                  preempt_count_add();
>  2)   0.110 us    |                  smp_call_function_many();
>  2)   0.105 us    |                  preempt_count_sub();
>  2)   0.764 us    |                }
>  2)   0.116 us    |                preempt_count_sub();
>  2)   3.676 us    |              }
>  2)   3.889 us    |            }
>  2)   4.087 us    |          }
>  2)               |          _raw_spin_lock() {
>  2)   0.112 us    |            preempt_count_add();
>  2)   0.315 us    |          }
>  2)               |          _raw_spin_unlock() {
>  2)   0.108 us    |            preempt_count_sub();
>  2)   0.309 us    |          }
>  2)               |          unlock_buffer() {
>  2)               |            wake_up_bit() {
>  2)   0.118 us    |              __wake_up_bit();
>  2)   0.317 us    |            }
>  2)   0.513 us    |          }
>  2)   7.440 us    |        }
>  2)   7.643 us    |      }
>  2)   8.070 us    |    }
> 
> 
> PG migration fails a lot:
> 
> pgmigrate_success 111063
> pgmigrate_fail 269841559
> compact_migrate_scanned 536253365
> compact_free_scanned 360889
> compact_isolated 270072733
> compact_stall 0
> compact_fail 0
> compact_success 0
> compact_daemon_wake 56
> compact_daemon_migrate_scanned 536253365
> compact_daemon_free_scanned 360889
> 
> Let me know if I can help with anything else. I'll keep the the box alive
> for a while, but will have to power it off eventually.
> 
> 	-ss
> 

