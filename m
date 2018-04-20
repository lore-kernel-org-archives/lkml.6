Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753472AbeDTRsJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:48:09 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.156]:20477 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752831AbeDTRsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:48:08 -0400
X-Authority-Reason: nr=8
Subject: Re: [PATCH] cifs: dir: fix memory leak in cifs_mknod
To: Steve French <smfrench@gmail.com>,
        Colin King <colin.king@canonical.com>
Cc: Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>, CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
References: <20180420131919.GA1766@embeddedor.com>
 <CAH2r5mtYQujfeEUpEiE557o3YccD9QwWCTLCJFbBoF7zbYcggQ@mail.gmail.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <67525f3c-f6f2-d1b2-c6eb-66b2315e6530@embeddedor.com>
Date: Fri, 20 Apr 2018 12:48:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAH2r5mtYQujfeEUpEiE557o3YccD9QwWCTLCJFbBoF7zbYcggQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.6.211
X-Source-L: No
X-Exim-ID: 1f9a8l-000V4Z-Fo
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.71]) [189.175.6.211]:34550
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 04/20/2018 12:37 PM, Steve French wrote:
> I noticed a similar problem with the tcon link leak on that (which
> Colin and Gustavo pointed out - thank you!) but also in another return
> statement, so updated the original patch of Ronnie's merging the fixes
> 
> https://git.samba.org/sfrench/cifs-2.6.git/?p=sfrench/cifs-2.6.git;a=commit;h=167bc5de08dc97695f9d5c7069c3e69f409ff80b
> 
> 
> Let me know if you see any problems with it.
> 

Looks correct to me.

Thanks
--
Gustavo

> On Fri, Apr 20, 2018 at 8:19 AM, Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>> Free allocated memory for full_path and xid before return.
>>
>> Addresses-Coverity-ID: 1468029 ("Resource leak")
>> Fixes: 49162bfde140 ("cifs: do not allow creating sockets except with
>> SMB1 posix exensions")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   fs/cifs/dir.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
>> index f0a759d..71e32d9 100644
>> --- a/fs/cifs/dir.c
>> +++ b/fs/cifs/dir.c
>> @@ -684,8 +684,11 @@ int cifs_mknod(struct inode *inode, struct dentry *direntry, umode_t mode,
>>                  goto mknod_out;
>>          }
>>
>> -       if (!S_ISCHR(mode) && !S_ISBLK(mode))
>> +       if (!S_ISCHR(mode) && !S_ISBLK(mode)) {
>> +               kfree(full_path);
>> +               free_xid(xid);
>>                  return -EPERM;
>> +       }
>>
>>          if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_UNX_EMUL))
>>                  goto mknod_out;
>> --
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-cifs" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
