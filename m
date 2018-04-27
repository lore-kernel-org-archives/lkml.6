Return-Path: <tmricht@linux.ibm.com>
X-Google-Smtp-Source: AB8JxZpSP/IUusOjLnWNe3zCs2y3ljf5men8NKg17rUgz6YbXlYhuG74TE45OTzgYDl51X6KI/FM
ARC-Seal: i=1; a=rsa-sha256; t=1524820474; cv=none;
        d=google.com; s=arc-20160816;
        b=XwcODBgZxrmeIz4XBONb5fLsIb2SoZnBAmOfGJZVCyiYBIyCF62bTlP1buJNN0wg5f
         fSfUeb4H0+OHVG2YNgHyPL86dtjAQdRrEJjG+otygH9Fmn6l3XtvXNn0l41OVZ5gLiWP
         M38RtzqL4hm9MQvtXSINU1K08+UEqtyo39J0Vi73G4RoY84iaHxBVCN2UWmZV/HJHozW
         QzSgtRb8y7Eh0riGpeUhP5txQ6ra4cSjDK2SH3ugLb0W+0CQxX6LMERkC53NEKe4VFy+
         C5SNSeefXLr9FKFlWtcGZF4sDYFa8bag9TXRYLcXzrWZ7N26jIeXILicx9EwOrSeszvR
         46pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=XWunTtr5FKf2sjC3BMCG9dCEd5zhe2J9EgFSMRNmZA0=;
        b=qPs4Gp81svWqusX/UJBhm8pEgY4NJrWIrndJIjLAHR9i+TdPIpnDEzXqo7rP9sv62D
         2T2FAOR0CWJ6QNTNiyA2LiiZGEzmxbwm6d7lLdC58/lyNAz+3YNdncqOAMigY3i+msvq
         xsDKib87CrTD/vw5wG6ZBcCt7SG5qdySboQfuH8cwETz3q4DXrnStw6ELxAObnfVKBMD
         qGdl4/fneMzeIwRx9g3wppSPGpXSLCkobL9R1OC+hxoXgBOFHLuk14rcJxCjspomr6+X
         jOHam+BFrDndjt6hZRYcrq+v2frscqJm+5r9lfEuGare/5Np/GPOmSec8qsQ3rPNBbad
         +Fug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tmricht@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=tmricht@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tmricht@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=tmricht@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH] inode: debugfs_create_dir uses mode permission from
 parent
To: Greg KH <gregkh@linuxfoundation.org>
Cc: brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
References: <20180427080712.2380-1-tmricht@linux.ibm.com>
 <20180427082737.GA25242@kroah.com>
From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date: Fri, 27 Apr 2018 11:14:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427082737.GA25242@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18042709-0040-0000-0000-00000452A4AA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042709-0041-0000-0000-000020F6B046
Message-Id: <504bade7-7b06-c9d4-e4e2-736b9ee5a313@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804270092
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598885939373348657?=
X-GMAIL-MSGID: =?utf-8?q?1598890154143653009?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 10:27 AM, Greg KH wrote:
> On Fri, Apr 27, 2018 at 10:07:12AM +0200, Thomas Richter wrote:
>> Currently function debugfs_create_dir() creates a new
>> directory in the debugfs (usually mounted /sys/kernel/debug)
>> with permission rwxr-xr-x. This is hard coded.
>>
>> Change this to use the parent directory permission.
>>
>> Fixes: edac65eaf8d5c ("debugfs: take mode-dependent parts of debugfs_get_inode() into callers")
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  fs/debugfs/inode.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
>> index 13b01351dd1c..80618330d86a 100644
>> --- a/fs/debugfs/inode.c
>> +++ b/fs/debugfs/inode.c
>> @@ -512,7 +512,10 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
>>  	if (unlikely(!inode))
>>  		return failed_creating(dentry);
>>  
>> -	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
>> +	if(!parent)
>> +		parent = debugfs_mount->mnt_root;
>> +	inode->i_mode = S_IFDIR | (d_inode(parent)->i_mode
>> +				   & (S_IRWXU | S_IRWXG));
>>  	inode->i_op = &simple_dir_inode_operations;
>>  	inode->i_fop = &simple_dir_operations;
>>  
> 
> This looks ok, but is it going to change the permissions of existing
> stuff in ways that might breaks things, right?

Right, but debugfs is usually mounted on /sys/kernel/debug with
permissions rwx to root owner. It can be changed after the mount, of course.
Unless this is done, the directory permissions for /sys/kernel/debug
will stop any descend regardless  of the subdirectory permissions.

> 
> Have you done a before/after comparison?

I have tested this patch on my Linux 4.17.0rc2 kernel on s390.
That worked well, I have not tested other systems.


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
