Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753057AbeCYASh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 20:18:37 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:34492 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbeCYASf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 20:18:35 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Thadeu Lima de Souza Cascardo <cascardo@debian.org>
Cc: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        indranil@chelsio.com, nirranjan@chelsio.com,
        stephen@networkplumber.org, ganeshgr@chelsio.com,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        davem@davemloft.net, viro@zeniv.linux.org.uk
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
        <f06cca21650affa10d83a28dbd7fb577792e35a9.1521888444.git.rahul.lakkireddy@chelsio.com>
        <20180324221849.GW14312@siri.cascardo.eti.br>
Date: Sat, 24 Mar 2018 19:17:18 -0500
In-Reply-To: <20180324221849.GW14312@siri.cascardo.eti.br> (Thadeu Lima de
        Souza Cascardo's message of "Sat, 24 Mar 2018 19:18:50 -0300")
Message-ID: <877eq1huup.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eztMV-0004Ee-Vw;;;mid=<877eq1huup.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ybq6Qbl+wMvOz66kpacLgOZpViETQ3u4=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Thadeu Lima de Souza Cascardo <cascardo@debian.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 12825 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.8 (0.0%), b_tie_ro: 2.0 (0.0%), parse: 1.08 (0.0%),
        extract_message_metadata: 12 (0.1%), get_uri_detail_list: 2.7 (0.0%),
        tests_pri_-1000: 3.7 (0.0%), tests_pri_-950: 1.14 (0.0%), tests_pri_-900:
        0.97 (0.0%), tests_pri_-400: 29 (0.2%), check_bayes: 28 (0.2%), b_tokenize: 9
        (0.1%), b_tok_get_all: 10 (0.1%), b_comp_prob: 3.3 (0.0%), b_tok_touch_all:
        3.4 (0.0%), b_finish: 0.64 (0.0%), tests_pri_0: 322 (2.5%),
        check_dkim_signature: 0.49 (0.0%), check_dkim_adsp: 2.6 (0.0%),
        tests_pri_500: 12449 (97.1%), poll_dns_idle: 12442 (97.0%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH net-next v2 2/2] cxgb4: collect hardware dump in second kernel
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thadeu Lima de Souza Cascardo <cascardo@debian.org> writes:

> On Sat, Mar 24, 2018 at 04:26:34PM +0530, Rahul Lakkireddy wrote:
>> Register callback to collect hardware/firmware dumps in second kernel
>> before hardware/firmware is initialized.  The dumps for each device
>> will be available under /sys/kernel/crashdd/cxgb4/ directory in second
>> kernel.
>> 
>> Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
>> Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
>> ---
>> v2:
>> - No Changes.
>> 
>> Changes since rfc v2:
>> - Update comments and commit message for sysfs change.
>> 
>> rfc v2:
>> - Updated dump registration to the new API in patch 1.
> [...]
>> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>> index e880be8e3c45..265cb026f868 100644
>> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
>> @@ -5527,6 +5527,18 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>  	if (err)
>>  		goto out_free_adapter;
>>  
>> +	if (is_kdump_kernel()) {
>> +		/* Collect hardware state and append to
>> +		 * /sys/kernel/crashdd/cxgb4/ directory
>> +		 */
>> +		err = cxgb4_cudbg_crashdd_add_dump(adapter);
>> +		if (err) {
>> +			dev_warn(adapter->pdev_dev,
>> +				 "Fail collecting crash device dump, err: %d. Continuing\n",
>> +				 err);
>> +			err = 0;
>> +		}
>> +	}
>>  
>
> The problem I see with this approach is that you require that the driver
> is built into the kdump kernel (or present as a module in the kdump
> initramfs), and that you will probe the device during the collection of
> the dumps.

Compared to doing something in a crashing kernel anything in the kdump
kernel is a walk in the park.  Nothing is trustable in a crashing
kernel.

> IMHO, if you are going to require the device to be probed by the same
> driver during kdump, you might just as well use the device object itself
> to present the crash data. I think that's what Stephen Hemminger meant
> when he said to use sysfs. No need at all for any special crashdd. Just
> add an attribute or attribute group to the device object.

Doing something with the device model might make sense.  I am not
certain it does.  It is quite possible the device is in such a weird
state that the device driver fails to initialize.  That doesn't
mean the device driver can't scrape the registers and present
meaningful information to the rest of the system.

Whatever you do with capturing the state needs to happen early before
the driver initializes and stomps on the relevant state.

I don't expect there is much for the driver model to do, unless we wish
to do something explicitly before the normal device probe methods
happen.  What we need is the infrastructure for catching what gets
read from the driver and placing it in the core dump.

> Otherwise, as Eric Biederman pointed out, you should just add that data
> into the vmcore before you kexec, so you don't even need to look at a
> different file, and the driver does not even need to be present in the
> kdump kernel.

No.  I do mean before a kexec on panic happens.  Doing anything with
gathering this kind of information before kexec on panic is a very very
very very bad idea that will almost certainly make crash dumps less
reliable.  Don't even think about doing extra work on the crash dump
path.  Not ever.  No.  No.  No.  No.

The reason we use kexec on panic instead just creating a core dump
in the kernel is that many have tried and no one has gotten the kernel
to create crash dumps when things go wrong and it matters.  Meanwhile
kexec on panic works more often than not.

I mean that /proc/vmcore is a device that is used to gather up the bits
of the crashing kernel and to present it in a format that is easy to
read/save.  The tools read /proc/vmcore.

The driver or whatever is gathering this information absolutely needs to
be in the kdump kernel.

Eric
