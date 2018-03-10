Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsjLlh2pXEH4TvcIE85GmCXMAkw2V9UdEWKxXZMmICzPWIiv5LbuthM56y5K7DLMdzNDH7k
ARC-Seal: i=1; a=rsa-sha256; t=1520641382; cv=none;
        d=google.com; s=arc-20160816;
        b=y9evea9Kau6+z00JheiqaVP+ZDlYCHGh7cs2tBcwW92bxVmSqTIlIjw1naIe7ysY//
         3Aom5nJxFWE2AusmO9c+lbuFUGr48itP0UEjE0ajmPa7Li7UB7k3hSN97MvqxXDdAAJR
         HRBd/KsoMHIad1302TmXkn4laditn4WqIET75lqZh+5Jk6MhB4aRBnzQTMZ9VOayphSd
         z36bja1YIn0g1BOY8ueDlVr2jTjR/yOrVwxRoerIyOZLHfO6nU1Dyfc7IBR3xRqtanPo
         xASHfe6EuBOkm1An0ih8MolP5tXes2ph6Nu/iz0iHRgFPyP477hWtVcScPoYfV6PFl6H
         Hnhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GIjT+ylj7ARHm2XNzXmb/JPlJ+EacUnRCA+6W/IJjMc=;
        b=juvcZcJzgSOCVN5X42Sv0vSmlGgE04lGMGK1WBwodh+qAdFA2+fJYX1lvtErx540WN
         Z/HcXBd4ac0nQsOoCmGMUMm3LADwKv0AleCnsdma/HneURH5dhzH7/n02ObwONp1MmgT
         LSTsoByim4s8a81gF8TOIb0HTgbX3cYAevuMKHOwGvOMbY9ZYSqSm4c6baOOuGBxU8Xl
         +hqW5Sk4TNxv9trI+2TNwmL7IFS1On05u4Uu0QR1Io/aul3jqcGKA3PQG/l3LjyQabSt
         P2SYapMfbRj2OV1RoKjkXvi5BOHx1hnHYajLx3wpkkBck0YLqS9O+saFSATheyPdzA1N
         MbtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"ast@kernel.org, daniel@iogearbox.net, stable@vger.kernel.org, Dennis Zhou" <dennisszhou@gmail.com>,
	syzbot+adb03f3f0bb57ce3acda@syzkaller.appspotmail.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Dennis Zhou <dennisszhou@gmail.com>
Subject: [PATCH 4.9 60/65] bpf: fix mlock precharge on arraymaps
Date: Fri,  9 Mar 2018 16:19:00 -0800
Message-Id: <20180310001830.129847750@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594508058053763900?=
X-GMAIL-MSGID: =?utf-8?q?1594508058053763900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ upstream commit 9c2d63b843a5c8a8d0559cc067b5398aa5ec3ffc ]

syzkaller recently triggered OOM during percpu map allocation;
while there is work in progress by Dennis Zhou to add __GFP_NORETRY
semantics for percpu allocator under pressure, there seems also a
missing bpf_map_precharge_memlock() check in array map allocation.

Given today the actual bpf_map_charge_memlock() happens after the
find_and_alloc_map() in syscall path, the bpf_map_precharge_memlock()
is there to bail out early before we go and do the map setup work
when we find that we hit the limits anyway. Therefore add this for
array map as well.

Fixes: 6c9059817432 ("bpf: pre-allocate hash map elements")
Fixes: a10423b87a7e ("bpf: introduce BPF_MAP_TYPE_PERCPU_ARRAY map")
Reported-by: syzbot+adb03f3f0bb57ce3acda@syzkaller.appspotmail.com
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Dennis Zhou <dennisszhou@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/arraymap.c |   29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -48,8 +48,9 @@ static struct bpf_map *array_map_alloc(u
 	bool percpu = attr->map_type == BPF_MAP_TYPE_PERCPU_ARRAY;
 	u32 elem_size, index_mask, max_entries;
 	bool unpriv = !capable(CAP_SYS_ADMIN);
+	u64 cost, array_size, mask64;
 	struct bpf_array *array;
-	u64 array_size, mask64;
+	int ret;
 
 	/* check sanity of attributes */
 	if (attr->max_entries == 0 || attr->key_size != 4 ||
@@ -92,8 +93,19 @@ static struct bpf_map *array_map_alloc(u
 		array_size += (u64) max_entries * elem_size;
 
 	/* make sure there is no u32 overflow later in round_up() */
-	if (array_size >= U32_MAX - PAGE_SIZE)
+	cost = array_size;
+	if (cost >= U32_MAX - PAGE_SIZE)
 		return ERR_PTR(-ENOMEM);
+	if (percpu) {
+		cost += (u64)attr->max_entries * elem_size * num_possible_cpus();
+		if (cost >= U32_MAX - PAGE_SIZE)
+			return ERR_PTR(-ENOMEM);
+	}
+	cost = round_up(cost, PAGE_SIZE) >> PAGE_SHIFT;
+
+	ret = bpf_map_precharge_memlock(cost);
+	if (ret < 0)
+		return ERR_PTR(ret);
 
 	/* allocate all map elements and zero-initialize them */
 	array = bpf_map_area_alloc(array_size);
@@ -108,20 +120,15 @@ static struct bpf_map *array_map_alloc(u
 	array->map.value_size = attr->value_size;
 	array->map.max_entries = attr->max_entries;
 	array->map.map_flags = attr->map_flags;
+	array->map.pages = cost;
 	array->elem_size = elem_size;
 
-	if (!percpu)
-		goto out;
-
-	array_size += (u64) attr->max_entries * elem_size * num_possible_cpus();
-
-	if (array_size >= U32_MAX - PAGE_SIZE ||
-	    elem_size > PCPU_MIN_UNIT_SIZE || bpf_array_alloc_percpu(array)) {
+	if (percpu &&
+	    (elem_size > PCPU_MIN_UNIT_SIZE ||
+	     bpf_array_alloc_percpu(array))) {
 		bpf_map_area_free(array);
 		return ERR_PTR(-ENOMEM);
 	}
-out:
-	array->map.pages = round_up(array_size, PAGE_SIZE) >> PAGE_SHIFT;
 
 	return &array->map;
 }
