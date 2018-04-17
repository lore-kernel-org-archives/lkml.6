Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeDQHLX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 03:11:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7173 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750967AbeDQHLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 03:11:22 -0400
Subject: Re: [PATCH 2/2] f2fs: support {d,id,did,x}node checksum
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: Chao Yu <chao@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20180127094301.29154-2-yuchao0@huawei.com>
 <20180131020213.GA86468@jaegeuk-macbookpro.roam.corp.google.com>
 <b65ee79a-8d3d-8ade-133b-913b2cbd0264@huawei.com>
 <20180131221531.GC12901@jaegeuk-macbookpro.roam.corp.google.com>
 <55f144df-4419-3642-5b35-c8885cdb7354@kernel.org>
 <20180210014140.GB1885@jaegeuk-macbookpro.roam.corp.google.com>
 <5f22d645-001d-a132-f0bd-2dba1f6daaea@kernel.org>
 <558ea6b1-e57d-5910-d931-a47f143cca25@huawei.com>
 <3782ed9e-741d-d711-3937-bc8127566982@kernel.org>
 <bd8580f5-a5a1-5e0a-ea01-088cffb441e4@huawei.com>
 <20180417033858.GB76077@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <6b8a1fa6-8f83-82f8-5136-d711c9048e09@huawei.com>
Date: Tue, 17 Apr 2018 15:11:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180417033858.GB76077@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/17 11:38, Jaegeuk Kim wrote:
> On 04/13, Chao Yu wrote:
>> Ping again..
>>
>> Do you have time to discuss this?
> 
> We may need a time to have a chat in person. Do you have any chance to visit
> US?

I prefer to, just count on LSF, but...

I think I need to find a conference which is opened in US first.

Just checked events.linuxfoundation.org, and didn't find any suitable conference
I could attend recently in US.

Location: US
Apr 18-20 Boston, Could Foundry Summit
Apr 23-25 Park City, LSF
Sep 24-26 Nashville, API strategy & practice
Oct 10-11 New York, Open FinTech Forum
Dec 11-13 Seattle, KubeCon & CloudNativeCon

Any other conferences?

Thanks,

> 
>>
>> On 2018/2/27 22:16, Chao Yu wrote:
>>> Ping,
>>>
>>> On 2018/2/13 15:34, Chao Yu wrote:
>>>> Hi Jaegeuk,
>>>>
>>>> On 2018/2/10 10:52, Chao Yu wrote:
>>>>> On 2018/2/10 9:41, Jaegeuk Kim wrote:
>>>>>> On 02/01, Chao Yu wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2018/2/1 6:15, Jaegeuk Kim wrote:
>>>>>>>> On 01/31, Chao Yu wrote:
>>>>>>>>> On 2018/1/31 10:02, Jaegeuk Kim wrote:
>>>>>>>>>> What if we want to add more entries in addition to node_checksum? Do we have
>>>>>>>>>> to add a new feature flag at every time? How about adding a layout value instead
>>>>>>>>>
>>>>>>>>> Hmm.. for previous implementation, IMO, we'd better add a new feature flag at
>>>>>>>>> every time, otherwise, w/ extra_nsize only, in current image, we can know a
>>>>>>>>> valid range of extended area in node block, but we don't know which
>>>>>>>>> fields/features are valid/enabled or not.
>>>>>>>>>
>>>>>>>>> One more thing is that if we can add one feature flag for each field, we got one
>>>>>>>>> more chance to disable it dynamically.
>>>>>>>>>
>>>>>>>>>> of extra_nsize? For example, layout #1 means node_checksum with extra_nsize=X?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> What does 1017 mean? We need to make this structure more flexibly for new
>>>>>>>>>
>>>>>>>>> Yes, using raw 1017 is not appropriate here.
>>>>>>>>>
>>>>>>>>>> entries. Like this?
>>>>>>>>>> 		union {
>>>>>>>>>> 			struct node_v1;
>>>>>>>>>> 			struct node_v2;
>>>>>>>>>> 			struct node_v3;
>>>>>>>>>> 			...
>>>>>>>>>> 			struct direct_node dn;
>>>>>>>>>> 			struct indirect_node in;
>>>>>>>>>> 		};
>>>>>>>>>> 	};
>>>>>>>>>>
>>>>>>>>>> 	struct node_v1 {
>>>>>>>>>> 		__le32 data[DEF_ADDRS_PER_BLOCK - V1_NSIZE=1];
>>>>>>>>>> 		__le32 node_checksum;
>>>>>>>>>> 	}
>>>>>>>>>>
>>>>>>>>>> 	struct node_v2 {
>>>>>>>>>> 		__le32 data[DEF_ADDRS_PER_BLOCK - V2_NSIZE=500];
>>>>>>>>>
>>>>>>>>> Hmm.. If we only need to add one more 4 bytes field in struct node_v2, but
>>>>>>>>> V2_NSIZE is defined as fixed 500, there must be 492 bytes wasted.
>>>>>>>>>
>>>>>>>>> Or we can define V2_NSIZE as 8, but if there comes more and more extended
>>>>>>>>> fields, node version count can be a large number, it results in complicated
>>>>>>>>> version recognization and handling.
>>>>>>>>>
>>>>>>>>> One more question is how can we control which fields are valid or not in
>>>>>>>>> comp[Vx_NSIZE]?
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Anyway, what I'm thinking is maybe we can restructure layout of node block like
>>>>>>>>> the one used by f2fs_inode:
>>>>>>>>>
>>>>>>>>> struct f2fs_node {
>>>>>>>>> 	union {
>>>>>>>>> 		struct f2fs_inode i;
>>>>>>>>> 		union {
>>>>>>>>> 			struct {
>>>>>>>>> 				__le32 node_checksum;
>>>>>>>>> 				__le32 feature_field_1;
>>>>>>>>> 				__le32 feature_field_2;
>>>>>>>>> 				....
>>>>>>>>> 				__le32 addr[];
>>>>>>>>> 				
>>>>>>>>> 			};
>>>>>>>>> 			struct direct_node dn;
>>>>>>>>> 			struct indirect_node in;
>>>>>>>>> 		};
>>>>>>>>> 	};
>>>>>>>>> 	struct node_footer footer;
>>>>>>>>> } __packed;
>>>>>>>>>
>>>>>>>>> Moving all extended fields to the head of f2fs_node, so we don't have to use
>>>>>>>>> macro to indicate actual size of addr.
>>>>>>>>
>>>>>>>> Thinking what'd be the best way. My concern is, once getting more entries, we
>>>>>>>
>>>>>>> OK, I think we need more discussion.. ;)
>>>>>>>
>>>>>>>> can't set each of features individually. Like the second entry should have
>>>>>>>
>>>>>>> Oh, that will be hard. If we have to avoid that, we have to tag in somewhere
>>>>>>> e.g. f2fs_inode::i_flags2 to indicate which new field in f2fs_node is valid, for
>>>>>>> example:
>>>>>>>
>>>>>>> #define F2FS_NODE_CHECKSUM	0x0001
>>>>>>> #define F2FS_NODE_FIELD1	0x0002
>>>>>>> #define F2FS_NODE_FIELD2	0x0004
>>>>>>>
>>>>>>> 	union {
>>>>>>> 		struct {
>>>>>>> 			__le32 node_checksum;
>>>>>>> 			__le32 field_1;
>>>>>>> 			__le32 field_2;
>>>>>>> 			....
>>>>>>> 			__le32 addr[];
>>>>>>> 		};
>>>>>>> 		struct direct_node dn;
>>>>>>> 		struct indirect_node in;
>>>>>>> 	};
>>>>>>>
>>>>>>> f2fs_inode::i_flags2 = F2FS_NODE_CHECKSUM | F2FS_NODE_FIELD1
>>>>>>> indicates that f2fs_node::node_checksum and f2fs_node::field_1 are valid;
>>>>>>>
>>>>>>> f2fs_inode::i_flags2 = F2FS_NODE_FIELD1 | F2FS_NODE_FIELD2
>>>>>>> indicates that f2fs_node::field_1 and f2fs_node::field_2 are valid.
>>>>>>
>>>>>> So, that's why I thought we may need a sort of each formats.
>>>>>
>>>>> Hmm.. if we have two new added fields, there are (2 << 2) combinations
>>>>> of all formats, as:
>>>>>
>>>>> struct original {
>>>>> 	__le32 data[DEF_ADDRS_PER_BLOCK];
>>>>> }
>>>>>
>>>>> struct node_v1 {
>>>>> 	__le32 data[DEF_ADDRS_PER_BLOCK - V1_NSIZE=1];
>>>>> 	__le32 field_1;
>>>>> }
>>>>>
>>>>> struct node_v2 {
>>>>> 	__le32 data[DEF_ADDRS_PER_BLOCK - V2_NSIZE=1];
>>>>> 	__le32 field_2;
>>>>> }
>>>>>
>>>>> struct node_v2 {
>>>>> 	__le32 data[DEF_ADDRS_PER_BLOCK - V3_NSIZE=2];
>>>>> 	__le32 field_1;
>>>>> 	__le32 field_2;
>>>>> }
>>>>>
>>>>> If we add more new fields, the node version will increase sharply due
>>>>> to there is (n << 2) combination with n fields. Right? Any thoughts to
>>>>> reduce maintaining overhead on those node versions structures?
>>>>
>>>> Do you have time to explain more about the design of multiple version structure
>>>> for node block, I'm still be confused about two things:
>>>> 1. what will we do if we want to add one new field in node structure.
>>>> 2. how can we recognize which fields are valid and which ones are invalid.
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Any thoughts?
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>>> enabled node_checksum, which we may not want to do.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>>
>>>>>>>>>> 		__le32 comp[V2_NSIZE];
>>>>>>>>>> 	}
>>>>>>>>>> 	...
>>>>>>>>>>
>>>>>>>>>>> +			};
>>>>>>>>>>> +			struct direct_node dn;
>>>>>>>>>>> +			struct indirect_node in;
>>>>>>>>>>> +		};
>>>>>>>>>>>  	};
>>>>>>>>>>>  	struct node_footer footer;
>>>>>>>>>>>  } __packed;
>>>>>>>>>>> -- 
>>>>>>>>>>> 2.15.0.55.gc2ece9dc4de6
>>>>>>>>>>
>>>>>>>>>> .
>>>>>>>>>>
>>>>>
>>>>> .
>>>>>
>>>>
>>>
>>> .
>>>
> 
> .
> 
