Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755355AbeDCKqX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 06:46:23 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:31635 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755254AbeDCKqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 06:46:21 -0400
Subject: Re: KASAN: use-after-free Read in alloc_pid
To: Eric Biggers <ebiggers3@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc: syzbot <syzbot+7a1cff37dbbef9e7ba4c@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, dhowells@redhat.com, gs051095@gmail.com,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        pasha.tatashin@oracle.com, riel@redhat.com, rppt@linux.vnet.ibm.com,
        syzkaller-bugs@googlegroups.com, wangkefeng.wang@huawei.com,
        viro@ZenIV.linux.org.uk
References: <94eb2c06406c59cccc0568c527c2@google.com>
 <878ta5z00m.fsf@xmission.com> <20180403031021.GB685@sol.localdomain>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <5a529481-6fd4-bc8d-6b13-31357d9ae633@I-love.SAKURA.ne.jp>
Date: Tue, 3 Apr 2018 19:45:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403031021.GB685@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/04/03 12:10, Eric Biggers wrote:
> On Mon, Apr 02, 2018 at 06:00:57PM -0500, Eric W. Biederman wrote:
>> syzbot <syzbot+7a1cff37dbbef9e7ba4c@syzkaller.appspotmail.com> writes:
>>
>>> Hello,
>>>
>>> syzbot hit the following crash on upstream commit
>>> 9dd2326890d89a5179967c947dab2bab34d7ddee (Fri Mar 30 17:29:47 2018 +0000)
>>> Merge tag 'ceph-for-4.16-rc8' of git://github.com/ceph/ceph-client
>>> syzbot dashboard link:
>>> https://syzkaller.appspot.com/bug?extid=7a1cff37dbbef9e7ba4c
>>>
>>> So far this crash happened 4 times on upstream.
>>>
>>> Unfortunately, I don't have any reproducer for this crash yet.
>>
>> Do you have any of the other traces?  This looks like a something is
>> calling put_pid_ns more than it is calling get_pid_ns causing a
>> reference count mismatch.
>>
>> If this is not: 9ee332d99e4d5a97548943b81c54668450ce641b

Yes, that commit is the trigger. Al wrote patches. Let's check them.

  http://lkml.kernel.org/r/20180402143415.GC30522@ZenIV.linux.org.uk
  http://lkml.kernel.org/r/20180403052009.GH30522@ZenIV.linux.org.uk

----------
struct pid *alloc_pid(struct pid_namespace *ns) {
(...snipped...)
    if (unlikely(is_child_reaper(pid))) {
        if (pid_ns_prepare_proc(ns)) // ns is freed upon failure.
            goto out_free;
    }
(...snipped...)
out_free:
    spin_lock_irq(&pidmap_lock);
    while (++i <= ns->level) // <= ns is already freed by destroy_pid_namespace() explained below.
        idr_remove(&ns->idr, (pid->numbers + i)->nr);
(...snipped...)
}
----------

----------
int pid_ns_prepare_proc(struct pid_namespace *ns) {
  mnt = kern_mount_data(&proc_fs_type, ns) { // <= ns is passed as ns.
    mnt = vfs_kern_mount(type, SB_KERNMOUNT, type->name, data) { // <= ns is passed as data.
      root = mount_fs(type, SB_KERNMOUNT, name, data) { // <= ns is passed as data.
        root = type->mount(type, SB_KERNMOUNT, name, data) = // <= ns is passed as data.
        static struct dentry *proc_mount(struct file_system_type *fs_type, int flags, const char *dev_name, void *data) {
          return mount_ns(fs_type, SB_KERNMOUNT, NULL, ns, ns->user_ns, proc_fill_super) { // <= ns is passed as ns.
            sb = sget_userns(fs_type, ns_test_super, ns_set_super, SB_KERNMOUNT, user_ns, ns) { // <= ns is passed as ns.
              err = set(s, data) = // <= ns is passed as data.
              static int ns_set_super(struct super_block *sb, void *data) {
                sb->s_fs_info = data; // ns is associated here.
              }
              err = register_shrinker(&s->s_shrink); // <= fail by fault injection.
              deactivate_locked_super(s) {
                fs->kill_sb(s) =
                static void proc_kill_sb(struct super_block *sb) {
                  ns = (struct pid_namespace *)sb->s_fs_info;
                  put_pid_ns(ns) { // <= ns is passed as ns
                    kref_put(&ns->kref, free_pid_ns) { // <= ns refcount becomes 0
                      destroy_pid_namespace(ns) {
                        call_rcu(&ns->rcu, delayed_free_pidns) {
                          kmem_cache_free(pid_ns_cachep, ns); // <= ns is released here after RCU grace period
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
----------

>>
>> I could use a few more hints to help narrow down what is going wrong.
>>
>> It would be nice to know what the other 3 crashes looked like and
>> exactly which upstream they were on.
>>
> 
> The other crashes are shown on the syzbot dashboard (link was given in the
> original email).
> 
> Eric
> 
