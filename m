Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeDEBtC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 21:49:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:60964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752642AbeDEBs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 21:48:57 -0400
Subject: Re: [PATCH?] reiserfs: prevent panic: don't allow %-char in journal
 dev. name
To: Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, reiserfs-devel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        syzkaller-bugs@googlegroups.com,
        syzbot+6bd77b88c1977c03f584@syzkaller.appspotmail.com
References: <d9b518a5-287a-72b3-05f1-ea89e25563ba@infradead.org>
 <20180404184517.9f2b91b856a56f71464f5f7f@linux-foundation.org>
From: Jeff Mahoney <jeffm@suse.com>
Message-ID: <5e9ea36a-6a6a-921c-81b3-bc623a9e125a@suse.com>
Date: Wed, 4 Apr 2018 21:48:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180404184517.9f2b91b856a56f71464f5f7f@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/18 9:45 PM, Andrew Morton wrote:
> On Wed, 4 Apr 2018 18:25:16 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> If the reiserfs mount option's journal name contains a '%' character,
>> it can lead to a WARN_ONCE() in lib/vsprintf.c::format_decode(),
>> saying: "Please remove unsupported %/ in format string."
>> That's OK until panic_on_warn is set, at which point it's dead, Jim.
>>
>> To placate this situation, check the journal name string for a '%'
>> character and return an error if one is found. Also print a warning
>> (one that won't panic the kernel) about the invalid journal name (e.g.):
>>
>>   reiserfs: journal device name is invalid: %/file0
>>
>> (In this example, the caller app specified the journal device name as
>> "%/file0".)
>>
> 
> Well, that is a valid filename and we should support it...
> 
> Isn't the bug in journal_init_dev()?

Yep.  That's exactly it.

Acked-by: Jeff Mahoney <jeffm@suse.com>

Thanks,

-Jeff

> --- a/fs/reiserfs/journal.c~a
> +++ a/fs/reiserfs/journal.c
> @@ -2643,7 +2643,7 @@ static int journal_init_dev(struct super
>  	if (IS_ERR(journal->j_dev_bd)) {
>  		result = PTR_ERR(journal->j_dev_bd);
>  		journal->j_dev_bd = NULL;
> -		reiserfs_warning(super,
> +		reiserfs_warning(super, "sh-457",
>  				 "journal_init_dev: Cannot open '%s': %i",
>  				 jdev_name, result);
>  		return result;
> _
> 
> 


-- 
Jeff Mahoney
SUSE Labs
