Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDA0C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C386A2151B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C386A2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbeHBQIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 12:08:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59010 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732419AbeHBQIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 12:08:48 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C3230D30E253A;
        Thu,  2 Aug 2018 22:17:19 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Thu, 2 Aug 2018
 22:17:20 +0800
Message-ID: <5B63126A.6000702@huawei.com>
Date:   Thu, 2 Aug 2018 22:17:14 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Matthew Wilcox <willy@infradead.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Laura Abbott <labbott@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Question] A novel case happened when using mempool allocate
 memory.
References: <5B61D243.9050608@huawei.com> <20180801153713.GA4039@bombadil.infradead.org> <5B62A30B.9000008@huawei.com> <20180802133134.GA11845@bombadil.infradead.org>
In-Reply-To: <20180802133134.GA11845@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/2 21:31, Matthew Wilcox wrote:
> On Thu, Aug 02, 2018 at 02:22:03PM +0800, zhong jiang wrote:
>> On 2018/8/1 23:37, Matthew Wilcox wrote:
>>> Please post the code.
>> when module is loaded. we create the specific mempool. The code flow is as follows.
> I actually meant "post the code you are testing", not "write out some
> pseudocode".
>
> .
>
The source code is as follow about mempool utility.

**
* @brief 元素的类型顺序与 @smio_mem_type_t的定义顺序一致
*/
static smio_mem_mng_t g_smio_mem[] =
{
{
.name = "MEDIA_INFO",
.min_pool_size = 128,
.item_size = sizeof(smio_media_info_t),
.slab_cache = NULL,
},
{
.name = "DSW_IO_REQ",
.min_pool_size = 1024,
.item_size = sizeof(dsw_io_req_t),
.slab_cache = NULL,
},
{
.name = "DSW_IO_PAGE",
.min_pool_size = 1024,
.item_size = sizeof(dsw_page_t) * DSW_MAX_PAGE_PER_REQ,
.slab_cache = NULL,
},
{
.name = "32_ARRAY",
.min_pool_size = 1024,
.item_size = sizeof(void *) * 32,
.slab_cache = NULL,
},
{
.name = "SCSI_SENSE_BUF",
.min_pool_size = 1024,
.item_size = sizeof(char) * SCSI_SENSE_BUFFERSIZE,
.slab_cache = NULL,
},
};

/**
* @brief 申请数据类型内存
*
* @param id 申请者模块ID
* @param type 申请内存的类型
*
* @return 成功返回内存块的首地址;失败返回NULL
*/
void *smio_mem_alloc(smio_module_id_t id, smio_mem_type_t type)
{
void *m = NULL;
smio_mem_mng_t *pool_mng = NULL;
SMIO_ASSERT_RETURN(id < SMIO_MOD_ID_BUTT, NULL);
SMIO_ASSERT_RETURN(type < SMIO_MEM_TYPE_BUTT, NULL);

pool_mng = &g_smio_mem[type];

SMIO_LOG_DEBUG("alloc %s, size: %d\n", pool_mng->name, pool_mng->item_size);

m = mempool_alloc(pool_mng->pool, GFP_KERNEL);
if (NULL == m)
{
return NULL;
}

memset(m, 0, pool_mng->item_size);

atomic_inc(&pool_mng->statistics[id]);

return m;
}
EXPORT_SYMBOL(smio_mem_alloc);


/**
* @brief 释放内存块
*
* @param id 申请者的模块ID
* @param type 内存块的类型
* @param m 内在的首地址
*/
void smio_mem_free(smio_module_id_t id, smio_mem_type_t type, void *m)
{
smio_mem_mng_t *pool_mng = NULL;
SMIO_ASSERT(NULL != m);
SMIO_ASSERT(id < SMIO_MOD_ID_BUTT);
SMIO_ASSERT(type < SMIO_MEM_TYPE_BUTT);

pool_mng = &g_smio_mem[type];

mempool_free(m, pool_mng->pool);

atomic_dec(&pool_mng->statistics[id]);
}
EXPORT_SYMBOL(smio_mem_free);


/**
* @brief 创建管理内在池
*
* @param pool_mng 内存类型管理结构
*
* @return 成功返回@SMIO_OK;失败返回@SMIO_ERR
*/
static int smio_mem_pool_create(smio_mem_mng_t *pool_mng)
{
int i;
SMIO_ASSERT_RETURN(NULL != pool_mng, SMIO_ERR);

pool_mng->slab_cache = kmem_cache_create(pool_mng->name,
pool_mng->item_size, 0, 0, NULL);

if (SMIO_IS_ERR_OR_NULL(pool_mng->slab_cache))
{
SMIO_LOG_ERR("kmem_cache_create for %s failed\n", pool_mng->name);
return SMIO_ERR;
}
pool_mng->pool = mempool_create(pool_mng->min_pool_size, mempool_alloc_slab,
mempool_free_slab, pool_mng->slab_cache);
if (NULL == pool_mng->pool)
{
SMIO_LOG_ERR("pool create for %s failed\n", pool_mng->name);
kmem_cache_destroy(pool_mng->slab_cache);
return SMIO_ERR;
}

for (i = 0; i < SMIO_MOD_ID_BUTT; i++)
{
atomic_set(&pool_mng->statistics[i], 0);
}

return SMIO_OK;
}


/**
* @brief 清除内存池
*
* @param pool_mng 所要清除的内存池
*/
void smio_mem_pool_destroy(smio_mem_mng_t *pool_mng)
{
SMIO_ASSERT(NULL != pool_mng);

if (NULL != pool_mng->pool)
{
mempool_destroy(pool_mng->pool);
pool_mng->pool = NULL;
}

if (NULL != pool_mng->slab_cache)
{
kmem_cache_destroy(pool_mng->slab_cache);
pool_mng->slab_cache = NULL;
}
}


/**
* @brief 内存管理单元初始化
*
* @return 成功返回@SMIO_OK;失败返回@SMIO_ERR
*/
int smio_mem_init(void)
{
int i;
int pool_num = (int) SMIO_ARRAY_SIZE(g_smio_mem);
int ret = SMIO_OK;
bool free = SMIO_FALSE;

for (i = 0; i < pool_num; i++)
{
SMIO_LOG_INFO("memory of %s initialize, min_pool_size: %d, item_size: %d\n",
g_smio_mem[i].name, g_smio_mem[i].min_pool_size, g_smio_mem[i].item_size);
if (SMIO_OK != smio_mem_pool_create(&g_smio_mem[i]))
{
SMIO_LOG_ERR("memory of %s initialize failed\n", g_smio_mem[i].name);
ret = SMIO_ERR;
free = SMIO_TRUE;
break;
}
}

/* clean if smio_mem_pool_create failed*/
while ((SMIO_TRUE == free) && (--i >= 0))
{
smio_mem_pool_destroy(&g_smio_mem[i]);
}

return ret;
}


/**
* @brief 内存管理模块清除退出
*/
void smio_mem_exit(void)
{
int i;
int pool_num = (int) SMIO_ARRAY_SIZE(g_smio_mem);

for (i = 0; i < pool_num; i++)
{
smio_mem_pool_destroy(&g_smio_mem[i]);
}
}



