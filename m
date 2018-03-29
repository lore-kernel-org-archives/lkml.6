Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/9S7Lg2NC3Vyylp4KMSqYeD0XGWOpiebs8iM6YKFPpbGCISoVWJmQp8KRjP+wZlnp94vxm
ARC-Seal: i=1; a=rsa-sha256; t=1522346537; cv=none;
        d=google.com; s=arc-20160816;
        b=qx9SUVhXOeOsyi7AE+7YKn1zRabcqe5wkjY/5O3QysZi+y5nQlaqFw3hJGYcn0Xz/z
         EVzJx0DedfIgi2XdmGURR8xaEsWSgCGucg9yP2ZANLB5c85TYVkb3dbZ32lLe5dvhvOu
         nCi2XqmU4WTQRRjygoRKt7Vh7E3xCnYwUa0PI0Gl+b3ZDdVXLxcwbUFlSfDSEpnZYktR
         yyWfWaSSmmthmgqPmlggaAEOEWvCEUOAfIlb237ukOW6zoxyw4e2XyvYl8vEaI/pUxKg
         LIWSsd0g/PR38n5IB7oG2AciKa/jxYFkGch7VYbn31E/fYq30e0v8mniDGoAcq0EjvWW
         wQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3FT+1k1vis8Z9msSL3RNmNODjcllDMWP+x4ci8RUdAo=;
        b=EgP3XW5LRu21iChc8N7jv0RRE5oAz/0oRYP6t5nW2UqE6xM3Bb7p4DklQbvQLZjAy1
         SlbXtXdbtgVYD2/8+YD/h7VJMSCiA0zpzO9ol4gHRiZgrYi7oSku0e4kW2Dglw145zYf
         pCwiNWn8Fx0QAU8UYP6omI4MJrlNKTzA2cWtmhhutJZ6hMlxc45ijyc9yjP5/YUScVOD
         W9/Mu1VdtysLYkekj4TMYB0rbdEOSx16luqINvpX111crBYoxyl7Jxwm9lADLS4SHEhR
         hZ3Ay4+ywPLQTR8t6kz4uZ3n5QhMfMSZgUSlhafk99yIOBoxAw88wt1MUulDIg4dsrej
         vNGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Blakey <paulb@mellanox.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 20/47] test_rhashtable: add test case for rhltable with duplicate objects
Date: Thu, 29 Mar 2018 20:00:01 +0200
Message-Id: <20180329175730.619549100@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296042678750736?=
X-GMAIL-MSGID: =?utf-8?q?1596296042678750736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Blakey <paulb@mellanox.com>


[ Upstream commit 499ac3b60f657dae82055fc81c7b01e6242ac9bc ]

Tries to insert duplicates in the middle of bucket's chain:
bucket 1:  [[val 21 (tid=1)]] -> [[ val 1 (tid=2),  val 1 (tid=0) ]]

Reuses tid to distinguish the elements insertion order.

Signed-off-by: Paul Blakey <paulb@mellanox.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/test_rhashtable.c |  134 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -79,6 +79,21 @@ struct thread_data {
 	struct test_obj *objs;
 };
 
+static u32 my_hashfn(const void *data, u32 len, u32 seed)
+{
+	const struct test_obj_rhl *obj = data;
+
+	return (obj->value.id % 10) << RHT_HASH_RESERVED_SPACE;
+}
+
+static int my_cmpfn(struct rhashtable_compare_arg *arg, const void *obj)
+{
+	const struct test_obj_rhl *test_obj = obj;
+	const struct test_obj_val *val = arg->key;
+
+	return test_obj->value.id - val->id;
+}
+
 static struct rhashtable_params test_rht_params = {
 	.head_offset = offsetof(struct test_obj, node),
 	.key_offset = offsetof(struct test_obj, value),
@@ -87,6 +102,17 @@ static struct rhashtable_params test_rht
 	.nulls_base = (3U << RHT_BASE_SHIFT),
 };
 
+static struct rhashtable_params test_rht_params_dup = {
+	.head_offset = offsetof(struct test_obj_rhl, list_node),
+	.key_offset = offsetof(struct test_obj_rhl, value),
+	.key_len = sizeof(struct test_obj_val),
+	.hashfn = jhash,
+	.obj_hashfn = my_hashfn,
+	.obj_cmpfn = my_cmpfn,
+	.nelem_hint = 128,
+	.automatic_shrinking = false,
+};
+
 static struct semaphore prestart_sem;
 static struct semaphore startup_sem = __SEMAPHORE_INITIALIZER(startup_sem, 0);
 
@@ -469,6 +495,112 @@ static int __init test_rhashtable_max(st
 	return err;
 }
 
+static unsigned int __init print_ht(struct rhltable *rhlt)
+{
+	struct rhashtable *ht;
+	const struct bucket_table *tbl;
+	char buff[512] = "";
+	unsigned int i, cnt = 0;
+
+	ht = &rhlt->ht;
+	tbl = rht_dereference(ht->tbl, ht);
+	for (i = 0; i < tbl->size; i++) {
+		struct rhash_head *pos, *next;
+		struct test_obj_rhl *p;
+
+		pos = rht_dereference(tbl->buckets[i], ht);
+		next = !rht_is_a_nulls(pos) ? rht_dereference(pos->next, ht) : NULL;
+
+		if (!rht_is_a_nulls(pos)) {
+			sprintf(buff, "%s\nbucket[%d] -> ", buff, i);
+		}
+
+		while (!rht_is_a_nulls(pos)) {
+			struct rhlist_head *list = container_of(pos, struct rhlist_head, rhead);
+			sprintf(buff, "%s[[", buff);
+			do {
+				pos = &list->rhead;
+				list = rht_dereference(list->next, ht);
+				p = rht_obj(ht, pos);
+
+				sprintf(buff, "%s val %d (tid=%d)%s", buff, p->value.id, p->value.tid,
+					list? ", " : " ");
+				cnt++;
+			} while (list);
+
+			pos = next,
+			next = !rht_is_a_nulls(pos) ?
+				rht_dereference(pos->next, ht) : NULL;
+
+			sprintf(buff, "%s]]%s", buff, !rht_is_a_nulls(pos) ? " -> " : "");
+		}
+	}
+	printk(KERN_ERR "\n---- ht: ----%s\n-------------\n", buff);
+
+	return cnt;
+}
+
+static int __init test_insert_dup(struct test_obj_rhl *rhl_test_objects,
+				  int cnt, bool slow)
+{
+	struct rhltable rhlt;
+	unsigned int i, ret;
+	const char *key;
+	int err = 0;
+
+	err = rhltable_init(&rhlt, &test_rht_params_dup);
+	if (WARN_ON(err))
+		return err;
+
+	for (i = 0; i < cnt; i++) {
+		rhl_test_objects[i].value.tid = i;
+		key = rht_obj(&rhlt.ht, &rhl_test_objects[i].list_node.rhead);
+		key += test_rht_params_dup.key_offset;
+
+		if (slow) {
+			err = PTR_ERR(rhashtable_insert_slow(&rhlt.ht, key,
+							     &rhl_test_objects[i].list_node.rhead));
+			if (err == -EAGAIN)
+				err = 0;
+		} else
+			err = rhltable_insert(&rhlt,
+					      &rhl_test_objects[i].list_node,
+					      test_rht_params_dup);
+		if (WARN(err, "error %d on element %d/%d (%s)\n", err, i, cnt, slow? "slow" : "fast"))
+			goto skip_print;
+	}
+
+	ret = print_ht(&rhlt);
+	WARN(ret != cnt, "missing rhltable elements (%d != %d, %s)\n", ret, cnt, slow? "slow" : "fast");
+
+skip_print:
+	rhltable_destroy(&rhlt);
+
+	return 0;
+}
+
+static int __init test_insert_duplicates_run(void)
+{
+	struct test_obj_rhl rhl_test_objects[3] = {};
+
+	pr_info("test inserting duplicates\n");
+
+	/* two different values that map to same bucket */
+	rhl_test_objects[0].value.id = 1;
+	rhl_test_objects[1].value.id = 21;
+
+	/* and another duplicate with same as [0] value
+	 * which will be second on the bucket list */
+	rhl_test_objects[2].value.id = rhl_test_objects[0].value.id;
+
+	test_insert_dup(rhl_test_objects, 2, false);
+	test_insert_dup(rhl_test_objects, 3, false);
+	test_insert_dup(rhl_test_objects, 2, true);
+	test_insert_dup(rhl_test_objects, 3, true);
+
+	return 0;
+}
+
 static int thread_lookup_test(struct thread_data *tdata)
 {
 	unsigned int entries = tdata->entries;
@@ -617,6 +749,8 @@ static int __init test_rht_init(void)
 	do_div(total_time, runs);
 	pr_info("Average test time: %llu\n", total_time);
 
+	test_insert_duplicates_run();
+
 	if (!tcount)
 		return 0;
 
