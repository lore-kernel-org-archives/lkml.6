Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05BCC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADC220824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 12:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADC220824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeJZVBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 17:01:16 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55635 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbeJZVBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 17:01:16 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9QCNw6n012693;
        Fri, 26 Oct 2018 21:23:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Fri, 26 Oct 2018 21:23:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9QCNs2E012681
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 26 Oct 2018 21:23:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: KASAN: use-after-free Read in task_is_descendant
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     serge@hallyn.com,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        jmorris@namei.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
 <20181022134634.GA7358@redhat.com>
 <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
 <20181025111355.GA3725@redhat.com>
 <b0ac67e6-4279-91b3-0178-3176876abe70@i-love.sakura.ne.jp>
 <20181025121709.GD3725@redhat.com>
 <d11bc954-5a30-e6bd-1668-866a187e0aac@i-love.sakura.ne.jp>
 <20181025155503.GF3725@redhat.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <3423a470-c152-0dbf-c7a7-2775a9679194@i-love.sakura.ne.jp>
Date:   Fri, 26 Oct 2018 21:23:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025155503.GF3725@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/26 0:55, Oleg Nesterov wrote:
> On 10/25, Tetsuo Handa wrote:
>>
>> On 2018/10/25 21:17, Oleg Nesterov wrote:
>>>>> And yes, task_is_descendant() can hit the dead child, if nothing else it can
>>>>> be killed. This can explain the kasan report.
>>>>
>>>> The kasan is reporting that child->real_parent (or maybe child->real_parent->real_parent
>>>> or child->real_parent->real_parent->real_parent ...) was pointing to already freed memory,
>>>> isn't it?
>>>
>>> Yes. and you know, I am all confused. I no longer can understand you :/
>>
>> Why don't we need to check every time like shown below?
>> Why checking only once is sufficient?
> 
> Why do you think it is not sufficient?
> 
> Again, I can be easily wrong, rcu is not simple, but so far I think we need
> a single check at the start.
> 

Hmm, this report is difficult to guess what happened.

Since the "child" passed to task_is_descendant() has at least one reference
count taken by find_get_task_by_vpid(), rcu_dereference(walker->real_parent)
in the first iteration

  while (child->pid > 0) {
    if (!thread_group_leader(child))
      walker = rcu_dereference(child->group_leader);
    if (walker == parent) {
      rc = 1;
      break;
    }
    walker = rcu_dereference(walker->real_parent);
  }

must not trigger use-after-free bug. Thus, when this use-after-free was
detected at rcu_dereference(walker->real_parent), the memory pointed by
"walker" must have been released between

  while (walker->pid > 0) {
    if (!thread_group_leader(walker))
      walker = rcu_dereference(walker->group_leader);

and

    walker = rcu_dereference(walker->real_parent);
  }

because otherwise use-after-free would have been reported at walker->pid
or thread_group_leader(walker) or rcu_dereference(walker->group_leader).

Is my understanding correct?



Then, what pid_alive(child) is testing? It is not memory pointed by "child" but
memory pointed by "walker" (i.e. parent of "child" or parent of parent of "child"
or ... ) which is triggering use-after-free.

Suppose p1 == p2->real_parent and p2 == p3->real_parent, and p1 exited
when p2 tried to attach on p1, p2->real_parent was pointing to already
(or about to be) freed p1.

Even if pid_alive(p2) test can guarantee that p1 won't be released,
how can pid_alive(p3) test guarantee that p1 won't be released?
p1 can be released any moment because it has already waited for RCU
grace period, can't it?


ptrace(PTRACE_ATTACH, vpid_of_p2) {
  p2 = find_get_task_by_vpid(vpid_of_p2);
  ptrace_attach(p2, PTRACE_ATTACH, addr, data) {
    mutex_lock_interruptible(&p2->signal->cred_guard_mutex);
    // p1 starts exit()ing here.
    task_lock(p2);
    __ptrace_may_access(p2) {
      // p2->real_parent starts pointing to already freed p1.
      security_ptrace_access_check(p2, PTRACE_MODE_ATTACH) {
        yama_ptrace_access_check() {
           task_is_descendant(current, p2) {
             walker = p2;
             rcu_read_lock();
             if (pid_alive(p2)) { // If true
               if (p2->pid > 0) { // will be true
                 p1 = rcu_dereference(p2->real_parent); // might be OK due to pid_alive(p2) == true?
               }
             }
             rcu_read_unlock();
           }
        }
      }
    }
    task_unlock(p2);
    mutex_unlock(&p2->signal->cred_guard_mutex);
  }
  put_task_struct(p2);
}

ptrace(PTRACE_ATTACH, vpid_of_p3) {
  p3 = find_get_task_by_vpid(vpid_of_p3);
  ptrace_attach(p3, PTRACE_ATTACH, addr, data) {
    mutex_lock_interruptible(&p3->signal->cred_guard_mutex);
    // p1 starts exit()ing here.
    task_lock(p3);
    __ptrace_may_access(p3) {
      // p2->real_parent starts pointing to already freed p1.
      security_ptrace_access_check(p3, PTRACE_MODE_ATTACH) {
        yama_ptrace_access_check() {
           task_is_descendant(current, p3) {
             walker = p3;
             rcu_read_lock();
             if (pid_alive(p3)) { // If true
               if (p3->pid > 0) { // will be true
                 p2 = rcu_dereference(p3->real_parent); // will be OK if above assumption is OK.
                 if (p2->pid > 0) { // will be true
                   p1 = rcu_dereference(p2->real_parent); // will read already (or about to be) freed p1 address
                   if (p1->pid > 0) { // Oops here or
                     if (!thread_group_leader(p1)) // oops here or
                       p1 = rcu_dereference(p1->group_leader); // oops here or
                     p0 = rcu_dereference(p1->real_parent); // oops here, or not oops because releasing after this
                   }
                 }
               }
             }
             rcu_read_unlock();
           }
        }
      }
    }
    task_unlock(p3);
    mutex_unlock(&p3->signal->cred_guard_mutex);
  }
  put_task_struct(p3);
}

