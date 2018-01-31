Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbeAaHPM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:15:12 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4748 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751826AbeAaHPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:15:11 -0500
Subject: Re: [PATCH 2/2] f2fs: support {d,id,did,x}node checksum
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20180127094301.29154-1-yuchao0@huawei.com>
 <20180127094301.29154-2-yuchao0@huawei.com>
 <20180131020213.GA86468@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <b65ee79a-8d3d-8ade-133b-913b2cbd0264@huawei.com>
Date: Wed, 31 Jan 2018 15:14:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180131020213.GA86468@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/1/31 10:02, Jaegeuk Kim wrote:
> What if we want to add more entries in addition to node_checksum? Do we have
> to add a new feature flag at every time? How about adding a layout value instead

Hmm.. for previous implementation, IMO, we'd better add a new feature flag at
every time, otherwise, w/ extra_nsize only, in current image, we can know a
valid range of extended area in node block, but we don't know which
fields/features are valid/enabled or not.

One more thing is that if we can add one feature flag for each field, we got one
more chance to disable it dynamically.

> of extra_nsize? For example, layout #1 means node_checksum with extra_nsize=X?
> 
> 
> What does 1017 mean? We need to make this structure more flexibly for new

Yes, using raw 1017 is not appropriate here.

> entries. Like this?
> 		union {
> 			struct node_v1;
> 			struct node_v2;
> 			struct node_v3;
> 			...
> 			struct direct_node dn;
> 			struct indirect_node in;
> 		};
> 	};
> 
> 	struct node_v1 {
> 		__le32 data[DEF_ADDRS_PER_BLOCK - V1_NSIZE=1];
> 		__le32 node_checksum;
> 	}
> 
> 	struct node_v2 {
> 		__le32 data[DEF_ADDRS_PER_BLOCK - V2_NSIZE=500];

Hmm.. If we only need to add one more 4 bytes field in struct node_v2, but
V2_NSIZE is defined as fixed 500, there must be 492 bytes wasted.

Or we can define V2_NSIZE as 8, but if there comes more and more extended
fields, node version count can be a large number, it results in complicated
version recognization and handling.

One more question is how can we control which fields are valid or not in
comp[Vx_NSIZE]?


Anyway, what I'm thinking is maybe we can restructure layout of node block like
the one used by f2fs_inode:

struct f2fs_node {
	union {
		struct f2fs_inode i;
		union {
			struct {
				__le32 node_checksum;
				__le32 feature_field_1;
				__le32 feature_field_2;
				....
				__le32 addr[];
				
			};
			struct direct_node dn;
			struct indirect_node in;
		};
	};
	struct node_footer footer;
} __packed;

Moving all extended fields to the head of f2fs_node, so we don't have to use
macro to indicate actual size of addr.

Thanks,

> 		__le32 comp[V2_NSIZE];
> 	}
> 	...
> 
>> +			};
>> +			struct direct_node dn;
>> +			struct indirect_node in;
>> +		};
>>  	};
>>  	struct node_footer footer;
>>  } __packed;
>> -- 
>> 2.15.0.55.gc2ece9dc4de6
> 
> .
> 
