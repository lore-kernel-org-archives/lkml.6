Return-Path: <anand.jain@oracle.com>
X-Google-Smtp-Source: AG47ELutbfvfxFCh6C/Ltzbc09np+dZnkWtOJZpOTwJx3zdvgc1NFN8oKEIJIz2/LdbjpoQW97yK
ARC-Seal: i=1; a=rsa-sha256; t=1521217159; cv=none;
        d=google.com; s=arc-20160816;
        b=fJuwXzrK4AWbnQvhyxR0NcVxnZKqy0bIvDC0vnpt9fimrQRX/pR7nolVB5he3y6vYQ
         u+EGQ2gLZNRj27i6RugSk76Rj2qJrbSTciwYQp2QS3EIxTAPmCCSXBIR1mJwS9bTkyza
         lR1o4m3BVLnOOXUapXSiZS6rVQ9d27QuaVQGMYPyIALTVbJRpsebpTlwqyAT3BLqKyrp
         Iik1nebTzHQcXCZp32kfu9xkGob4ZSTs6LqIQ6TtDQbpvv9Ou/i8U3vbb8ExPZf7ROdi
         aZmOexdUebhPv47byhGYnnLeA2FOhfHYpesgumaILCqAt4hFUvyrH9LkD+6mqvgYyn19
         lWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=b7gMZSDWJ2ZNFljidkd8L0iMKm83bvHF0UxVJ3sL/iY=;
        b=FHBQ/RJugtZg9w/mZkKaoWcOEyDRcPaTPnLd7uOekLbVoByWmoi/ubFe1NBWsyTuOL
         6fUOr02MaxhY6UtVJWXnPcxR6PD23jEoGGTaHvMQrjYp8T9RapvgC8T0opulolYikc1Y
         4uU18gGf4n+IkXArO5lTO+DOM+eNkwFZCZNg/iLQnDf6a8bFten00dJZHC+35YAsY7VM
         7guiflHh2WQ1VOJ5k2qeUQTjPoVdgpGUtFDO5UAE8PZRz2VgeN4EI/N70jMrjql1S1Jc
         T57xQmLK67khxgSCr683v8Qm+aYgBiWOUxiHbnQGeVbIeBDKUhwOKC9TH63pAP9N9GP1
         rFxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=uUu7hcvl;
       spf=pass (google.com: domain of anand.jain@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=anand.jain@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=uUu7hcvl;
       spf=pass (google.com: domain of anand.jain@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=anand.jain@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH 4.14 024/110] btrfs: use proper endianness accessors for
 super_copy
To: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>
References: <20180307191039.748351103@linuxfoundation.org>
 <20180307191042.810088712@linuxfoundation.org>
 <1521139304@msgid.manchmal.in-ulm.de>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <f5dc1577-356a-5a0f-193b-d421d61ce45c@oracle.com>
Date: Sat, 17 Mar 2018 00:21:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521139304@msgid.manchmal.in-ulm.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8833 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803160153
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594309090147375870?=
X-GMAIL-MSGID: =?utf-8?q?1595111804716115225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/16/2018 02:55 AM, Christoph Biedl wrote:
> Greg Kroah-Hartman wrote...
> 
>> 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
>> commit 3c181c12c431fe33b669410d663beb9cceefcd1b upstream.
> (...)
> 
>> If the filesystem is always used on a same endian host, this will not
>> be a problem.
> 
>  From my observations I cannot quite subscribe to that.
> 
> On big-endian systems, this change intruduces severe corruption,
> resulting in complete loss of the data on the used block device.

Thanks for the report.

That's really bad, my mistake. I am digging to know how it happened. 
Our on-disk root bytenr are little-endian compatible.  So using the 
cpu_to_le for write on a big-endian arch is a correct thing to do. If it 
fails,  certainly there is something which I have overlooked. I am 
digging to know. Thanks for the report again.

Fsck won't be able to figure out the correct on-disk btyenr either.

If there isn't any backup we could try to find out the correct pointers 
manually.  However, restore from the backup approach is much better.

-Anand


> Steps to reproduce (tested on ppc/powerpc and parisc/hppa):
> 
> # mkfs.btrfs $DEV
> # mount $DEV /mnt/tmp/
> # umount /mnt/tmp/
> 
> This simple umount corrupts the file system:
> 
> # mount $DEV /mnt/tmp/
> mount: /mnt/tmp: wrong fs type, bad option, bad superblock on $DEV, missing codepage or helper program, or other error.
> 
> # dmesg:
> BTRFS critical (device <dev>): unable to find logical 4294967296 length 4096
> BTRFS critical (device <dev>): unable to find logical 4294967296 length 4096
> BTRFS critical (device <dev>): unable to find logical 18102363734671360 length 16384
> BTRFS error (device <dev>): failed to read chunk root
> BTRFS error (device <dev>): open_ctree failed
> 
> Also fsck is of no help:
> 
> # btrfsck $DEV
> Couldn't map the block 18102363734671360
> No mapping for 18102363734671360-18102363734687744
> Couldn't map the block 18102363734671360
> bytenr mismatch, want=18102363734671360, have=0
> ERROR: cannot read chunk root
> ERROR: cannot open file system
> 
> 
> Trying mount or fsck on a little-endian system does not help either. So
> I consider the data on that device lost - luckily I use btrfs only for
> files where a backup exists all the time.
> 
> 
> Reverting that change restored the previous error-free behaviour. I
> didn't check HEAD, i.e. v4.16-rc5, since the upstream commt was the last
> that affected these files. Still I could give this a try if anybody
> wishes so.
> 
> Cheers,
> 
>      Christoph
> 
