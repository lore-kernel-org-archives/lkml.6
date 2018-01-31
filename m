Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeAaBZ2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 20:25:28 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:46361 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbeAaBZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 20:25:26 -0500
X-Google-Smtp-Source: AH8x2277VXqO4t2w9loAXEGub61MqE5b2gPOoJx3XvHchk079cGuEIALZrANDtNnYFmqdsnBxiKuEQ==
Reply-To: minyard@acm.org
Subject: Re: [PATCH arm/aspeed/ast2500 v2] ipmi: add an Aspeed KCS IPMI BMC
 driver
To: "Wang, Haiyue" <haiyue.wang@linux.intel.com>, joel@jms.id.au,
        avifishman70@gmail.com, openbmc@lists.ozlabs.org,
        openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@intel.com
References: <1516810009-16353-1-git-send-email-haiyue.wang@linux.intel.com>
 <f20da565-6644-3ea4-823b-a808cf613958@gmail.com>
 <76454c8b-b8ab-06a5-297c-83bab32c86a7@linux.intel.com>
 <f6a94b94-da37-7dee-afab-85ec83afb92c@acm.org>
 <d12b53d2-9364-bc60-565f-a07a9dd138bc@linux.intel.com>
 <68373e92-8c8b-73b4-094d-dfe51d07b04c@acm.org>
 <96bc417d-8a34-e693-a3aa-9400e6a3437d@linux.intel.com>
 <0e412f6b-240e-0210-50c2-3b8e8d2ee0e4@acm.org>
 <b705f117-58e8-c001-cf25-dfcd56a88f7c@linux.intel.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <86ec00c1-2ebe-93b0-2c39-ce12286b1d83@acm.org>
Date: Tue, 30 Jan 2018 19:25:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b705f117-58e8-c001-cf25-dfcd56a88f7c@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/2018 07:02 PM, Wang, Haiyue wrote:
>
>
> On 2018-01-31 08:52, Corey Minyard wrote:
>> On 01/30/2018 06:02 PM, Wang, Haiyue wrote:
>>>
>>>
>>> On 2018-01-30 21:49, Corey Minyard wrote:
>>>> On 01/29/2018 07:57 AM, Wang, Haiyue wrote:
>>>>>
>>>>>
>>>>> On 2018-01-26 22:48, Corey Minyard wrote:
>>>>>> On 01/26/2018 12:08 AM, Wang, Haiyue wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2018-01-25 01:48, Corey Minyard wrote:
>>>>>>>> On 01/24/2018 10:06 AM, Haiyue Wang wrote:
>>>>>>>>> The KCS (Keyboard Controller Style) interface is used to 
>>>>>>>>> perform in-band
>>>>>>>>> IPMI communication between a server host and its BMC 
>>>>>>>>> (BaseBoard Management
>>>>>>>>> Controllers).
>>>>>>>>>
>>>>>>>>> This driver exposes the KCS interface on ASpeed SOCs (AST2400 
>>>>>>>>> and AST2500)
>>>>>>>>> as a character device. Such SOCs are commonly used as BMCs and 
>>>>>>>>> this driver
>>>>>>>>> implements the BMC side of the KCS interface.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
>>>>>>>>>
>>>>>>>>> ---
>>>>>>>>> v1->v2
>>>>>>>>>
>>>>>>>>> - Divide the driver into two parts, one handles the BMC KCS 
>>>>>>>>> IPMI 2.0 state;
>>>>>>>>>    the other handles the BMC KCS controller such as AST2500 IO 
>>>>>>>>> accessing.
>>>>>>>>> - Use the spin lock APIs to handle the device file operations 
>>>>>>>>> and BMC chip
>>>>>>>>>    IRQ inferface for accessing the same KCS BMC data structure.
>>>>>>>>> - Enhanced the phases handling of the KCS BMC.
>>>>>>>>> - Unified the IOCTL definition for IPMI BMC, it will be used 
>>>>>>>>> by KCS and BT.
>>>>>>>>>
>>>>>>>>> ---
>>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +static void kcs_bmc_handle_data(struct kcs_bmc *kcs_bmc)
>>>>>>>>> +{
>>>>>>>>> +    u8 data;
>>>>>>>>> +
>>>>>>>>> +    switch (kcs_bmc->phase) {
>>>>>>>>> +    case KCS_PHASE_WRITE:
>>>>>>>>> +        set_state(kcs_bmc, WRITE_STATE);
>>>>>>>>> +
>>>>>>>>> +        /* set OBF before reading data */
>>>>>>>>> +        write_data(kcs_bmc, KCS_ZERO_DATA);
>>>>>>>>> +
>>>>>>>>> +        if (kcs_bmc->data_in_idx < KCS_MSG_BUFSIZ)
>>>>>>>>> + kcs_bmc->data_in[kcs_bmc->data_in_idx++] =
>>>>>>>>> +                        read_data(kcs_bmc);
>>>>>>
>>>>>> I missed this earlier, you need to issue a length error if the 
>>>>>> data is too large.
>>>>>>
>>>>>>>>> +        break;
>>>>>>>>> +
>>>>>>>>> +    case KCS_PHASE_WRITE_END:
>>>>>>>>> +        set_state(kcs_bmc, READ_STATE);
>>>>>>>>> +
>>>>>>>>> +        if (kcs_bmc->data_in_idx < KCS_MSG_BUFSIZ)
>>>>>>>>> + kcs_bmc->data_in[kcs_bmc->data_in_idx++] =
>>>>>>>>> +                        read_data(kcs_bmc);
>>>>>>>>> +
>>>>>>>>> +        kcs_bmc->phase = KCS_PHASE_WAIT_READ;
>>>>>>>>> +        if (kcs_bmc->running) {
>>>>>>>>
>>>>>>>> Why do you only do this when running is set?  It won't hurt 
>>>>>>>> anything if it's not
>>>>>>>> set.  As it is, you have a race if something opens the device 
>>>>>>>> while this code
>>>>>>>> runs.
>>>>>>>>
>>>>>>>> Also, don't set the state to wait read until the "write" has 
>>>>>>>> finished (userland has
>>>>>>>> read the data out of the buffer.  More on that later.
>>>>>>>>
>>>>>>> Understood.
>>>>>>>>> + kcs_bmc->data_in_avail = true;
>>>>>>>>> + wake_up_interruptible(&kcs_bmc->queue);
>>>>>>>>> +        }
>>>>>>>>> +        break;
>>>>>>>>> +
>>>>>>>>> +    case KCS_PHASE_READ:
>>>>>>>>> +        if (kcs_bmc->data_out_idx == kcs_bmc->data_out_len)
>>>>>>>>> +            set_state(kcs_bmc, IDLE_STATE);
>>>>>>>>> +
>>>>>>>>> +        data = read_data(kcs_bmc);
>>>>>>>>> +        if (data != KCS_CMD_READ_BYTE) {
>>>>>>>>> +            set_state(kcs_bmc, ERROR_STATE);
>>>>>>>>> +            write_data(kcs_bmc, KCS_ZERO_DATA);
>>>>>>>>> +            break;
>>>>>>>>> +        }
>>>>>>>>> +
>>>>>>>>> +        if (kcs_bmc->data_out_idx == kcs_bmc->data_out_len) {
>>>>>>>>> +            write_data(kcs_bmc, KCS_ZERO_DATA);
>>>>>>>>> +            kcs_bmc->phase = KCS_PHASE_IDLE;
>>>>>>>>> +            break;
>>>>>>>>> +        }
>>>>>>>>> +
>>>>>>>>> +        write_data(kcs_bmc,
>>>>>>>>> + kcs_bmc->data_out[kcs_bmc->data_out_idx++]);
>>>>>>>>> +        break;
>>>>>>>>> +
>>>>>>>>> +    case KCS_PHASE_ABORT_ERROR1:
>>>>>>>>> +        set_state(kcs_bmc, READ_STATE);
>>>>>>>>> +
>>>>>>>>> +        /* Read the Dummy byte */
>>>>>>>>> +        read_data(kcs_bmc);
>>>>>>>>> +
>>>>>>>>> +        write_data(kcs_bmc, kcs_bmc->error);
>>>>>>>>> +        kcs_bmc->phase = KCS_PHASE_ABORT_ERROR2;
>>>>>>>>> +        break;
>>>>>>>>> +
>>>>>>>>> +    case KCS_PHASE_ABORT_ERROR2:
>>>>>>>>> +        set_state(kcs_bmc, IDLE_STATE);
>>>>>>>>> +
>>>>>>>>> +        /* Read the Dummy byte */
>>>>>>>>> +        read_data(kcs_bmc);
>>>>>>>>> +
>>>>>>>>> +        write_data(kcs_bmc, KCS_ZERO_DATA);
>>>>>>>>> +        kcs_bmc->phase = KCS_PHASE_IDLE;
>>>>>>>>> +
>>>>>>>>> +        break;
>>>>>>>>> +
>>>>>>>>> +    default:
>>>>>>>>> +        set_state(kcs_bmc, ERROR_STATE);
>>>>>>>>> +
>>>>>>>>> +        /* Read the Dummy byte */
>>>>>>>>> +        read_data(kcs_bmc);
>>>>>>>>> +
>>>>>>>>> +        write_data(kcs_bmc, KCS_ZERO_DATA);
>>>>>>>>> +        break;
>>>>>>>>> +    }
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static void kcs_bmc_handle_command(struct kcs_bmc *kcs_bmc)
>>>>>>>>> +{
>>>>>>>>> +    u8 cmd;
>>>>>>>>> +
>>>>>>>>> +    set_state(kcs_bmc, WRITE_STATE);
>>>>>>>>> +
>>>>>>>>> +    /* Dummy data to generate OBF */
>>>>>>>>> +    write_data(kcs_bmc, KCS_ZERO_DATA);
>>>>>>>>> +
>>>>>>>>> +    cmd = read_data(kcs_bmc);
>>>>>>>>
>>>>>>>> Shouldn't you check the phase in all the cases below and do error
>>>>>>>> handling if the phase isn't correct?
>>>>>>>>
>>>>>>>> Similar thing if the device here isn't open.  You need to handle
>>>>>>>> that gracefully.
>>>>>>>>
>>>>>>>> Also, you should remove data_in_avail and data_in_idx setting from
>>>>>>>> here, for reasons I will explain later.
>>>>>>>>
>>>>>>> If host software sends the data twice such as a retry before the 
>>>>>>> BMC's IPMI service starts,
>>>>>>> then the two IPMI requests will be merged into one, if not clear 
>>>>>>> data_in_idx after receving
>>>>>>> KCS_CMD_WRITE_START. Most of the states are driven by host 
>>>>>>> software (SMS). :(
>>>>>>
>>>>>> True, but what if the host issues WRITE_START or a WRITE_END 
>>>>>> while this driver is in read
>>>>>> state?  The spec is unclear on this, but it really only makes 
>>>>>> sense for the host to issue
>>>>>> WRITE_START in idle stat and WRITE_END in write state. IMHO it 
>>>>>> should go to error
>>>>>> state.  You might make the case that a WRITE_START anywhere 
>>>>>> restarts the transaction,
>>>>>> but the feel of the error state machine kind of goes against 
>>>>>> that. WRITE_END is definitely
>>>>>> wrong anywhere but write state.
>>>>>>
>>>>>> I just found the following in the spec (section 9.12):
>>>>>>
>>>>>>    Thus, since the interface will allow a command transfer to be
>>>>>>    started or restarted
>>>>>>    at any time when the input buffer is empty, software could 
>>>>>> elect to
>>>>>>    simply retry
>>>>>>    the command upon detecting an error condition, or issue a 
>>>>>> ‘known good’
>>>>>>    command in order to clear ERROR_STATE
>>>>>>
>>>>>> So a WRITE_START anywhere is ok.  A WRITE_END in the wrong state 
>>>>>> should probably
>>>>>> still go to error state.  This means the user needs to be able to 
>>>>>> handle a write error at
>>>>>> any time.  It also means it's very important to make sure the 
>>>>>> user does a read before
>>>>>> doing a write.  If the host re-issues a WRITE_START and writes a 
>>>>>> new command
>>>>>> between the time the use reads the data and writes the response, 
>>>>>> the response would
>>>>>> be for the wrong command.
>>>>>>
>>>>>>>>> +    switch (cmd) {
>>>>>>>>> +    case KCS_CMD_WRITE_START:
>>>>>>>>> +        kcs_bmc->data_in_avail = false;
>>>>>>>>> +        kcs_bmc->data_in_idx   = 0;
>>>>>>>>> +        kcs_bmc->phase         = KCS_PHASE_WRITE;
>>>>>>>>> +        kcs_bmc->error         = KCS_NO_ERROR;
>>>>>>>>> +        break;
>>>>>>>>> +
>>>>>>>>> +    case KCS_CMD_WRITE_END:
>>>>>>>>> +        kcs_bmc->phase = KCS_PHASE_WRITE_END;
>>>>>>>>> +        break;
>>>>>>>>> +
>>>>>>>>> +    case KCS_CMD_ABORT:
>>>>>>>>> +        if (kcs_bmc->error == KCS_NO_ERROR)
>>>>>>>>> +            kcs_bmc->error = KCS_ABORTED_BY_COMMAND;
>>>>>>>>> +
>>>>>>>>> +        kcs_bmc->phase = KCS_PHASE_ABORT_ERROR1;
>>>>>>>>> +        break;
>>>>>>>>> +
>>>>>>>>> +    default:
>>>>>>>>> +        kcs_bmc->error = KCS_ILLEGAL_CONTROL_CODE;
>>>>>>>>> +        set_state(kcs_bmc, ERROR_STATE);
>>>>>>>>> +        write_data(kcs_bmc, kcs_bmc->error);
>>>>>>>>> +        kcs_bmc->phase = KCS_PHASE_ERROR;
>>>>>>>>> +        break;
>>>>>>>>> +    }
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +int kcs_bmc_handle_event(struct kcs_bmc *kcs_bmc)
>>>>>>>>> +{
>>>>>>>>> +    unsigned long flags;
>>>>>>>>> +    int ret = 0;
>>>>>>>>> +    u8 status;
>>>>>>>>> +
>>>>>>>>> +    spin_lock_irqsave(&kcs_bmc->lock, flags);
>>>>>>>>> +
>>>>>>>>> +    status = read_status(kcs_bmc) & (KCS_STATUS_IBF | 
>>>>>>>>> KCS_STATUS_CMD_DAT);
>>>>>>>>> +
>>>>>>>>> +    switch (status) {
>>>>>>>>> +    case KCS_STATUS_IBF | KCS_STATUS_CMD_DAT:
>>>>>>>>> +        kcs_bmc_handle_command(kcs_bmc);
>>>>>>>>> +        break;
>>>>>>>>> +
>>>>>>>>> +    case KCS_STATUS_IBF:
>>>>>>>>> +        kcs_bmc_handle_data(kcs_bmc);
>>>>>>>>> +        break;
>>>>>>>>> +
>>>>>>>>> +    default:
>>>>>>>>> +        ret = -1;
>>>>>>>>> +        break;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    spin_unlock_irqrestore(&kcs_bmc->lock, flags);
>>>>>>>>> +
>>>>>>>>> +    return ret;
>>>>>>>>> +}
>>>>>>>>> +EXPORT_SYMBOL(kcs_bmc_handle_event);
>>>>>>>>> +
>>>>>>>>> +static inline struct kcs_bmc *file_kcs_bmc(struct file *filp)
>>>>>>>>> +{
>>>>>>>>> +    return container_of(filp->private_data, struct kcs_bmc, 
>>>>>>>>> miscdev);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static int kcs_bmc_open(struct inode *inode, struct file *filp)
>>>>>>>>> +{
>>>>>>>>> +    struct kcs_bmc *kcs_bmc = file_kcs_bmc(filp);
>>>>>>>>> +    int ret = 0;
>>>>>>>>> +
>>>>>>>>> +    spin_lock_irq(&kcs_bmc->lock);
>>>>>>>>> +
>>>>>>>>> +    if (!kcs_bmc->running) {
>>>>>>>>> +        kcs_bmc->running       = 1;
>>>>>>>>> +        kcs_bmc->phase         = KCS_PHASE_IDLE;
>>>>>>>>> +        kcs_bmc->data_in_avail = false;
>>>>>>>>
>>>>>>>> If you do everything right, setting the phase and data_in_avail 
>>>>>>>> should not
>>>>>>>> be necessary here.
>>>>>>>>
>>>>>>>>> +    } else {
>>>>>>>>> +        ret = -EBUSY;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    spin_unlock_irq(&kcs_bmc->lock);
>>>>>>>>> +
>>>>>>>>> +    return ret;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static unsigned int kcs_bmc_poll(struct file *filp, 
>>>>>>>>> poll_table *wait)
>>>>>>>>> +{
>>>>>>>>> +    struct kcs_bmc *kcs_bmc = file_kcs_bmc(filp);
>>>>>>>>> +    unsigned int mask = 0;
>>>>>>>>> +
>>>>>>>>> +    poll_wait(filp, &kcs_bmc->queue, wait);
>>>>>>>>> +
>>>>>>>>> +    spin_lock_irq(&kcs_bmc->lock);
>>>>>>>>> +
>>>>>>>>> +    if (kcs_bmc->data_in_avail)
>>>>>>>>> +        mask |= POLLIN;
>>>>>>>>> +
>>>>>>>>> +    spin_unlock_irq(&kcs_bmc->lock);
>>>>>>>>> +
>>>>>>>>> +    return mask;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static ssize_t kcs_bmc_read(struct file *filp, char *buf,
>>>>>>>>> +                size_t count, loff_t *offset)
>>>>>>>>> +{
>>>>>>>>> +    struct kcs_bmc *kcs_bmc = file_kcs_bmc(filp);
>>>>>>>>> +    ssize_t ret = -EAGAIN;
>>>>>>>>> +
>>>>>>>>
>>>>>>>> This function still has some issues.
>>>>>>>>
>>>>>>>> You can't call copy_to_user() with a spinlock held or 
>>>>>>>> interrupts disabled.
>>>>>>>> To handle readers, you probably need a separate mutex.
>>>>>>>>
>>>>>>>> Also, this function can return -EAGAIN even if O_NONBLOCK is 
>>>>>>>> not set if
>>>>>>>> kcs_bmc->data_in_avail changes between when you wait on the event
>>>>>>>> and when you check it under the lock.
>>>>>>>>
>>>>>>>> You also clear data_in_avail even if the copy_to_user() fails, 
>>>>>>>> which is
>>>>>>>> wrong.
>>>>>>>>
>>>>>>>> I believe the best way to handle this would be to have the 
>>>>>>>> spinlock
>>>>>>>> protect the inner workings of the state machine and a mutex handle
>>>>>>>> copying data out, setting/clearing the running flag (thus a mutex
>>>>>>>> instead of spinlock in open and release) and the ioctl settings 
>>>>>>>> (except
>>>>>>>> for abort where you will need to grab the spinlock).
>>>>>>>>
>>>>>>>> After the wait event below, grab the mutex.  If data is not 
>>>>>>>> available
>>>>>>>> and O_NONBLOCK is not set, drop the mutex and retry. Otherwise
>>>>>>>> this is the only place (besides release) that sets 
>>>>>>>> data_in_avail to false.
>>>>>>>> Do the copy_to_user(), grab the spinlock, clear data_in_avail and
>>>>>>>> data_in_idx, then release the lock and mutex.  If you are really
>>>>>>>> adventurous you can do this without grabbing the lock using
>>>>>>>> barriers, but it's probably not necessary here.
>>>>>>>>
>>>>>>
>>>>>> With the state machine being able to be restarted at any time, 
>>>>>> you need
>>>>>> something a little different here.  You still need the mutex to 
>>>>>> handle
>>>>>> multiple readers and the copy.  I think the function should be 
>>>>>> something
>>>>>> like:
>>>>>>
>>>>> Since KCS is not a multi-reader protocol from BMC's view, you 
>>>>> makes things complex. :-)
>>>>
>>>> No, I don't think you understand.  The primary purpose of the 
>>>> complexity
>>>> here is to protect the driver from the host system (on the other 
>>>> side of
>>>> the KCS interface).  Without this protection, it is possible for 
>>>> the host
>>>> system to start a new write while the user on the BMC side is reading
>>>> data out, resulting in corrupt data being read.
>>>>
>>>> I haven't thought too much about this.  There may be a simpler way,
>>>> but the protection needs to be there.
>>>>
>>>> And you may not think you need to protect the driver against a
>>>> malicious BMC side user code, but you would be wrong.  You can
>>>> only have one opener, but with threads or a fork you can have
>>>> multiple readers.  And you don't know if a malicious piece of
>>>> code has taken over userland.  You always need to protect the
>>>> kernel.
>>>>
>>> Sure, the read/write have protected the critical data area with IRQ, 
>>> and also, these
>>> functions should be thread local safe I believe.
>>>
>>> spin_lock_irq(&kcs_bmc->lock);
>>> ...
>>> spin_unlock_irq(&kcs_bmc->lock);
>>>
>>
>> But remember, you can't call copy_to_user() when IRQs are off or when 
>> you are holding
>> a spinlock.  That is an absolute no.  It can crash the kernel.
>>
>> So you need a design that takes this into account, but will not 
>> result in the possibility
>> of bad data being read.
>>
> Yes, sure, as I said before: access_ok(VERIFY_WRITE, to, n), then 
> memcpy in spin_lock.

Where did you get the idea that this was ok?  It's not.  access_ok() is 
not actually very
useful, since the permissions on memory can change at any time unless 
you are holding
the mm lock, which is also not an ok thing to do.  It is entirely 
possible for access_ok()
to pass and copy_to_user() to fail.

I'm not exactly sure what you are saying, though.  In any event, a 
well-designed read()/write()
operation should leave the system unchanged if it gets an error.

-corey

>>>>>>    static ssize_t kcs_bmc_read(struct file *filp, char *buf,
>>>>>>                     size_t count, loff_t *offset)
>>>>>>    {
>>>>>>         struct kcs_bmc *kcs_bmc = file_kcs_bmc(filp);
>>>>>>         ssize_t ret;
>>>>>>         bool avail;
>>>>>>         size_t data_size;
>>>>>>         u8 *data;
>>>>>>
>>>>>>         data = kmalloc(KCS_MSG_BUFSIZ, GFP_KERNEL);
>>>>>>         if (!data)
>>>>>>             return -ENOMEM;
>>>>>>
>>>>>>    retry:
>>>>>>         ret = -EAGAIN;
>>>>>>         if (!(filp->f_flags & O_NONBLOCK))
>>>>>>             wait_event_interruptible(kcs_bmc->queue,
>>>>>>                          kcs_bmc->data_in_avail);
>>>>>>
>>>>>>         mutex_lock(&kcs_bmc->read_mutex);
>>>>>>
>>>>>>         spin_lock_irq(&kcs_bmc->lock);
>>>>>>         avail = kcs_bmc->data_in_avail;
>>>>>>         if (avail) {
>>>>>>             memcpy(data, kcs_bmc->data_in, kcs_bmc->data_in_idx);
>>>>>>             data_size = kcs_bmc->data_in_idx;
>>>>>>         }
>>>>>>         spin_unlock_irq(&kcs_bmc->lock);
>>>>>>
>>>>>>         if (!avail) {
>>>>>>             if (filp->f_flags & O_NONBLOCK)
>>>>>>                 goto out_mutex_unlock;
>>>>>>             mutex_unlock(&kcs_bmc->read_mutex);
>>>>>>             goto retry;
>>>>>>         }
>>>>>>
>>>>>>         if (count < data_size) {
>>>>>>             ret = -EOVERFLOW;
>>>>>>              ? I'm not sure about the error, but userspace needs 
>>>>>> to know.
>>>>>>             goto out_mutex_unlock;
>>>>
>>>> Maybe a length error to the host side here?
>>
>> You didn't comment on this or the other length error.  That needs to be
>> handled.
>>
> Yes, will send a length error by following KCS spec.
>>>>
>>>>>>         }
>>>>>>
>>>>>>         if (!copy_to_user(buf, data, data_size)) {
>>>>>>             ret = -EFAULT;
>>>>>>             goto out_mutex_unlock;
>>>>>>         }
>>>>>>
>>>>>>         ret = data_size;
>>>>>>
>>>>>>         spin_lock_irq(&kcs_bmc->lock);
>>>>>>
>>>>>>         if (kcs_bmc->phase != KCS_PHASE_WRITE_END_DONE)
>>>>>>             /* Something aborted or restarted the state machine. */
>>>>>>             ? Maybe restart if O_NONBLOCK is not set and -EAGAIN 
>>>>>> if it is?
>>>>>>             ret = -EIO;
>>>>>>         } else {
>>>>>>             kcs_bmc->phase = KCS_PHASE_WAIT_READ;
>>>>>>             kcs_bmc->data_in_avail = false;
>>>>>>             kcs_bmc->data_in_idx = 0;
>>>>>>         }
>>>>>>
>>>>>>         spin_unlock_irq(&kcs_bmc->lock);
>>>>>>
>>>>>>    out_mutex_unlock:
>>>>>>         mutex_unlock(&kcs_bmc->read_mutex);
>>>>>>
>>>>>>         kfree(data);
>>>>>>
>>>>>>         return ret;
>>>>>>    }
>>>>>> Note that I added a state, KCS_PHASE_WRITE_END_DONE, which would be
>>>>>> set after the final byte from the host is received.  You want the 
>>>>>> read here
>>>>>> done before you can do the write below to avoid the race I talked 
>>>>>> about.
>>>>>>
>>>>>> There is a local copy made of the data.  What you *never* want to 
>>>>>> happen
>>>>>> here is for the state machine to start processing a new write 
>>>>>> command
>>>>>> while the data is being copied.  It could result in corrupt data 
>>>>>> being read
>>>>>> and some random operation being done by the BMC.
>>>>>>
>>>>>> If you want to avoid the local copy, it could be done, but it's 
>>>>>> more complex.
>>>>>>
>>>>>>>>> +    if (!(filp->f_flags & O_NONBLOCK))
>>>>>>>>> + wait_event_interruptible(kcs_bmc->queue,
>>>>>>>>> +                     kcs_bmc->data_in_avail);
>>>>>>>>> +
>>>>>>>>> +    spin_lock_irq(&kcs_bmc->lock);
>>>>>>>>> +
>>>>>>>>> +    if (kcs_bmc->data_in_avail) {
>>>>>>>>> +        kcs_bmc->data_in_avail = false;
>>>>>>>>> +
>>>>>>>>> +        if (count > kcs_bmc->data_in_idx)
>>>>>>>>> +            count = kcs_bmc->data_in_idx;
>>>>>>>>> +
>>>>>>>>> +        if (!copy_to_user(buf, kcs_bmc->data_in, count))
>>>>>>>>> +            ret = count;
>>>>>>>>> +        else
>>>>>>>>> +            ret = -EFAULT;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    spin_unlock_irq(&kcs_bmc->lock);
>>>>>>>>> +
>>>>>>>>> +    return ret;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static ssize_t kcs_bmc_write(struct file *filp, const char *buf,
>>>>>>>>> +                 size_t count, loff_t *offset)
>>>>>>>>> +{
>>>>>>>>> +    struct kcs_bmc *kcs_bmc = file_kcs_bmc(filp);
>>>>>>>>> +    ssize_t ret = count;
>>>>>>>>> +
>>>>>>>>> +    if (count < 1 || count > KCS_MSG_BUFSIZ)
>>>>>>>>> +        return -EINVAL;
>>>>>>>>> +
>>>>>>>>> +    spin_lock_irq(&kcs_bmc->lock);
>>>>>>>>> +
>>>>>>>>> +    if (kcs_bmc->phase == KCS_PHASE_WAIT_READ) {
>>>>>>>>> +        if (copy_from_user(kcs_bmc->data_out, buf, count)) {
>>>>>>>>> + spin_unlock_irq(&kcs_bmc->lock);
>>>>>>>>> +            return -EFAULT;
>>>>>>>>> +        }
>>>>>>>>> +
>>>>>>>>> +        kcs_bmc->phase = KCS_PHASE_READ;
>>>>>>>>> +        kcs_bmc->data_out_idx = 1;
>>>>>>>>> +        kcs_bmc->data_out_len = count;
>>>>>>>>> +        write_data(kcs_bmc, kcs_bmc->data_out[0]);
>>>>>>>>> +    } else if (kcs_bmc->phase == KCS_PHASE_READ) {
>>>>>>>>> +        ret = -EBUSY;
>>>>>>>>> +    } else {
>>>>>>>>> +        ret = -EINVAL;
>>>>>>>>
>>>>>>>> Is there a reason you return -EINVAL here?  Why not just -EBUSY 
>>>>>>>> in all
>>>>>>>> cases?  Is there something that userland will need to do 
>>>>>>>> differently?
>>>>>>>>
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    spin_unlock_irq(&kcs_bmc->lock);
>>>>>>>>> +
>>>>>>>>> +    return ret;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static long kcs_bmc_ioctl(struct file *filp, unsigned int cmd,
>>>>>>>>> +              unsigned long arg)
>>>>>>>>> +{
>>>>>>>>> +    struct kcs_bmc *kcs_bmc = file_kcs_bmc(filp);
>>>>>>>>> +    long ret = 0;
>>>>>>>>> +
>>>>>>>>> +    spin_lock_irq(&kcs_bmc->lock);
>>>>>>>>> +
>>>>>>>>> +    switch (cmd) {
>>>>>>>>> +    case IPMI_BMC_IOCTL_SET_SMS_ATN:
>>>>>>>>> +        update_status_bits(kcs_bmc, KCS_STATUS_SMS_ATN,
>>>>>>>>> +                        KCS_STATUS_SMS_ATN);
>>>>>>>>> +        break;
>>>>>>>>> +
>>>>>>>>> +    case IPMI_BMC_IOCTL_CLEAR_SMS_ATN:
>>>>>>>>> +        update_status_bits(kcs_bmc, KCS_STATUS_SMS_ATN,
>>>>>>>>> +                        0);
>>>>>>>>> +        break;
>>>>>>>>> +
>>>>>>>>> +    case IPMI_BMC_IOCTL_FORCE_ABORT:
>>>>>>>>> +        set_state(kcs_bmc, ERROR_STATE);
>>>>>>>>> +        read_data(kcs_bmc);
>>>>>>>>> +        write_data(kcs_bmc, KCS_ZERO_DATA);
>>>>>>>>> +
>>>>>>>>> +        kcs_bmc->phase = KCS_PHASE_ERROR;
>>>>>>>>> +        kcs_bmc->data_in_avail = false;
>>>>>>>>> +        break;
>>>>>>>>> +
>>>>>>>>> +    default:
>>>>>>>>> +        ret = -EINVAL;
>>>>>>>>> +        break;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    spin_unlock_irq(&kcs_bmc->lock);
>>>>>>>>> +
>>>>>>>>> +    return ret;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static int kcs_bmc_release(struct inode *inode, struct file 
>>>>>>>>> *filp)
>>>>>>>>> +{
>>>>>>>>> +    struct kcs_bmc *kcs_bmc = file_kcs_bmc(filp);
>>>>>>>>> +
>>>>>>>>
>>>>>>>> What happens if the device gets closed in the middle of a 
>>>>>>>> transaction?  That's
>>>>>>>> an important case to handle.  If something is in process, you 
>>>>>>>> need to abort it.
>>>>>>>>
>>>>>>> The device just provides the read & write data, the transaction 
>>>>>>> is handled in the KCS
>>>>>>> controller's IRQ handler.
>>>>>>
>>>>>> From the spec, section 9.14:
>>>>>>
>>>>>>    The BMC must change the status to ERROR_STATE on any condition 
>>>>>> where it
>>>>>>    aborts a command transfer in progress.
>>>>>>
>>>>>> So you need to do something here.
>>>>>>
>>>>> In practice, we do this as spec said in ipmid, NOT in driver, 
>>>>> driver can't handle anything, let's
>>>>> make it simple, thanks!
>>>>
>>>> If ipmid crashes or is killed, how does it accomplish this?
>>>>
>>> Every time ipmids (or kcsd) crashed or killed, it needs start to 
>>> call FORCE_ARBORT firstly, to sync with
>>> host side software.
>>>>>
>>>>> Whenever the BMC is reset (from power-on or a hard reset), the 
>>>>> State Bits are initialized to “11 - Error State”. Doing so
>>>>> allows SMS to detect that the BMC has been reset and that any 
>>>>> message in process has been terminated by the BMC.
>>>>
>>>> Right, that's fine, like it should be.  But we are not talking 
>>>> about a reset.
>>>>
>>> I think the final error handling solution is that kcsd (user land) 
>>> runs, otherwise, the host software side still got stuck. We meet
>>> this kind of issue, so in general, we just doesn't handle some 
>>> mirror errors in driver, then in kcsd, when it can provide the real
>>> IPMI service, it will reset the channel firstly to sync with host 
>>> side software.
>>
>> "Userland will do the right thing" is not very convincing to a kernel 
>> developer.
>>
>> Plus if the above is true, I would think that you would just want to 
>> hold the device
>> in an error state when it wasn't opened.
>>
> I understand your concern, of course, driver need handles things well. 
> But in fact, if a user app is truly a bad boy, it still can hang
> the host side: set SMS_ATN, but no message returned when software host 
> side requests, then host open-ipmi driver will hang, we
> meet this kind of error to hang the customer's host. :) In my 
> understanding, kcs-bmc should do the right thing about read and write,
> the real transaction should be handled correctly by the kcsd.
>
> And if no kcsd starts, then this kind of BMC can't be sold out. :)

True.  I'm not as concerned about this sort of thing.  It's nicer to the 
host side if
it can detect problems quickly, but it will eventually time out.

 From what I can tell from the current design, if the BMC userland is 
not running,
the driver will step through the state machine until it hits read state, 
then it
will sit there until the host times out and aborts the operation.

IMHO, it would be better for the host side if the driver just stayed in 
error state
if nothing had it open.  It would think the spec says that in the quote 
I referenced
above, but that quote, like many things in the IPMI spec, is fairly 
vague and could
be interpreted many ways.

-corey


>> -corey
>>
>>>> -corey
>>>>
>>>>>>>>> + spin_lock_irq(&kcs_bmc->lock);
>>>>>>>>> +
>>>>>>>>> +    kcs_bmc->running = 0;
>>>>>>>>> +
>>>>>>>>> +    spin_unlock_irq(&kcs_bmc->lock);
>>>>>>>>> +
>>>>>>>>> +    return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
>
