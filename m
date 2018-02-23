Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751762AbeBWQzy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:55:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751366AbeBWQzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:55:52 -0500
Subject: Re: [PATCH v8 8/8] livepatch: Atomic replace and cumulative patches
 documentation
To: Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180221132914.4809-1-pmladek@suse.com>
 <20180221132914.4809-9-pmladek@suse.com>
 <alpine.LSU.2.21.1802231139030.26550@pobox.suse.cz>
From: Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <a50b564b-e0c8-321f-cf90-8c001e52499b@redhat.com>
Date: Fri, 23 Feb 2018 11:55:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1802231139030.26550@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 05:41 AM, Miroslav Benes wrote:
> On Wed, 21 Feb 2018, Petr Mladek wrote:
> 
>> User documentation for the atomic replace feature. It makes it easier
>> to maintain livepatches using so-called cumulative patches.
>>
>> Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> Acked-by: Miroslav Benes <mbenes@suse.cz>
> 
> Joe, are you planning to extend shadow vars documentation you mentioned 
> before (v7), or do you want Petr to do it?

I created a sample cumulative patch for testing (I can post later),
but I had a quick question regarding the callbacks...

>From v8 of the patch:

  + Only the (un)patching callbacks from the _new_ cumulative livepatch are
    executed. Any callbacks from the replaced patches are ignored.

maybe I'm not testing this as intended, but I'm not seeing this
behavior with the latest version of the patch.  See below.


Init
====

Setup dynamic debug messages:

  % echo "file kernel/livepatch/* +p" > /sys/kernel/debug/dynamic_debug/control
  % echo "func klp_try_switch_task -p" >> /sys/kernel/debug/dynamic_debug/control


Test 1
======

Copy the original callbacks demo, leave the atomic .replace feature off:

diff -upr samples/livepatch/livepatch-callbacks-{demo.c,demo2.c}
--- samples/livepatch/livepatch-callbacks-demo.c        2018-02-23 09:42:10.370223095 -0500
+++ samples/livepatch/livepatch-callbacks-demo2.c       2018-02-23 11:38:08.372557153 -0500
@@ -191,6 +191,7 @@ static struct klp_object objs[] = {
 static struct klp_patch patch = {
        .mod = THIS_MODULE,
        .objs = objs,
+       .replace = false,
 };
 
 static int livepatch_callbacks_demo_init(void)


Load the two modules, disable and unload:

  % dmesg -C
  % insmod samples/livepatch/livepatch-callbacks-demo.ko
  % insmod samples/livepatch/livepatch-callbacks-demo2.ko
  % echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo2/enabled
  % echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo/enabled
  % rmmod samples/livepatch/livepatch-callbacks-demo2.ko
  % rmmod samples/livepatch/livepatch-callbacks-demo.ko

All callbacks are called for both livepatch modules (expected):

  % dmesg
  [ 5755.608999] livepatch: enabling patch 'livepatch_callbacks_demo'
  [ 5755.609014] livepatch: 'livepatch_callbacks_demo': initializing patching transition
> [ 5755.609054] livepatch_callbacks_demo: pre_patch_callback: vmlinux
  [ 5755.609055] livepatch: 'livepatch_callbacks_demo': starting patching transition
  [ 5756.704163] livepatch: 'livepatch_callbacks_demo': completing patching transition
> [ 5756.704259] livepatch_callbacks_demo: post_patch_callback: vmlinux
  [ 5756.704260] livepatch: 'livepatch_callbacks_demo': patching complete
  [ 5760.231035] livepatch: enabling patch 'livepatch_callbacks_demo2'
  [ 5760.231038] livepatch: 'livepatch_callbacks_demo2': initializing patching transition
> [ 5760.231077] livepatch_callbacks_demo2: pre_patch_callback: vmlinux
  [ 5760.231078] livepatch: 'livepatch_callbacks_demo2': starting patching transition
  [ 5761.696067] livepatch: 'livepatch_callbacks_demo2': completing patching transition
> [ 5761.696166] livepatch_callbacks_demo2: post_patch_callback: vmlinux
  [ 5761.696166] livepatch: 'livepatch_callbacks_demo2': patching complete
  [ 5765.738278] livepatch: 'livepatch_callbacks_demo2': initializing unpatching transition
> [ 5765.738319] livepatch_callbacks_demo2: pre_unpatch_callback: vmlinux
  [ 5765.738319] livepatch: 'livepatch_callbacks_demo2': starting unpatching transition
  [ 5767.712143] livepatch: 'livepatch_callbacks_demo2': completing unpatching transition
> [ 5767.712502] livepatch_callbacks_demo2: post_unpatch_callback: vmlinux
  [ 5767.712503] livepatch: 'livepatch_callbacks_demo2': unpatching complete
  [ 5770.909701] livepatch: 'livepatch_callbacks_demo': initializing unpatching transition
> [ 5770.909743] livepatch_callbacks_demo: pre_unpatch_callback: vmlinux
  [ 5770.909743] livepatch: 'livepatch_callbacks_demo': starting unpatching transition
  [ 5772.704108] livepatch: 'livepatch_callbacks_demo': completing unpatching transition
> [ 5772.704215] livepatch_callbacks_demo: post_unpatch_callback: vmlinux
  [ 5772.704216] livepatch: 'livepatch_callbacks_demo': unpatching complete


Test 2
======

Make the second livepatch a cumulative one:

diff -upr samples/livepatch/livepatch-callbacks-{demo.c,demo2.c}
--- samples/livepatch/livepatch-callbacks-demo.c        2018-02-23 09:42:10.370223095 -0500
+++ samples/livepatch/livepatch-callbacks-demo2.c       2018-02-23 11:16:20.557557153 -0500
@@ -191,6 +191,7 @@ static struct klp_object objs[] = {
 static struct klp_patch patch = {
        .mod = THIS_MODULE,
        .objs = objs,
+       .replace = true,
 };
 
 static int livepatch_callbacks_demo_init(void)

Load the two modules, disable and unload:

  % dmesg -C
  % insmod samples/livepatch/livepatch-callbacks-demo.ko
  % insmod samples/livepatch/livepatch-callbacks-demo2.ko
  % echo 0 > /sys/kernel/livepatch/livepatch_callbacks_demo2/enabled
  % rmmod samples/livepatch/livepatch-callbacks-demo2.ko
  % rmmod samples/livepatch/livepatch-callbacks-demo.ko

Pre and post patch callbacks are called for both modules (expected), but
*no* unpatch callbacks are executed:

  % dmesg
  [ 5442.244332] livepatch: enabling patch 'livepatch_callbacks_demo'
  [ 5442.244334] livepatch: 'livepatch_callbacks_demo': initializing patching transition
> [ 5442.244372] livepatch_callbacks_demo: pre_patch_callback: vmlinux
  [ 5442.244372] livepatch: 'livepatch_callbacks_demo': starting patching transition
  [ 5444.704089] livepatch: 'livepatch_callbacks_demo': completing patching transition
> [ 5444.704183] livepatch_callbacks_demo: post_patch_callback: vmlinux
  [ 5444.704184] livepatch: 'livepatch_callbacks_demo': patching complete
  [ 5448.567820] livepatch: enabling patch 'livepatch_callbacks_demo2'
  [ 5448.567823] livepatch: 'livepatch_callbacks_demo2': initializing patching transition
> [ 5448.567860] livepatch_callbacks_demo2: pre_patch_callback: vmlinux
  [ 5448.567861] livepatch: 'livepatch_callbacks_demo2': starting patching transition
  [ 5451.744131] livepatch: 'livepatch_callbacks_demo2': completing patching transition
> [ 5451.744212] livepatch_callbacks_demo2: post_patch_callback: vmlinux
  [ 5451.744213] livepatch: 'livepatch_callbacks_demo2': patching complete
  [ 5455.002339] livepatch: 'livepatch_callbacks_demo2': initializing unpatching transition
  [ 5455.002378] livepatch: 'livepatch_callbacks_demo2': starting unpatching transition
  [ 5456.736068] livepatch: 'livepatch_callbacks_demo2': completing unpatching transition
  [ 5456.736132] livepatch: 'livepatch_callbacks_demo2': unpatching complete


BTW, should we just add this test-case to the doc / samples?

-- Joe
