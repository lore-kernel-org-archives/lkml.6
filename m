Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518412616; cv=none;
        d=google.com; s=arc-20160816;
        b=O/hoRQLmMKeDet4TlG8hfLURqVNEUSqK2ERq4TNoaTFI28plHtAMmq1Ag/03xiqZ7n
         gpPN0APwthNX020NsS29Cisg98YXEerGJy3khmIDDBZcsjEuOiWqJv6Tt045+ZL/9HLk
         WiyEBujR6ai1TRBKZttH5Rwyy++/E7i0hOFdSLuLSYfX4QXeUU0jHZ/+5dYkdY43/Xj0
         FxX3bE9wKStw7vBOAC3EOp1W7677nmSHvWfQeKdy8gTnkw29jNQYAwXTxDAfE7C1M3XF
         ekX7UeaoTFBwnRnTpffkcrYGUbhwkP5twGxIJEZKknE2UA5FrdrazYfHkjFtjNmUBASK
         aktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=rNzHqYsvJJiXVpH19xWBuCpdAEWoaA62sThTAClHcLk=;
        b=etr1HXChWZG8qc73f1xHuez3ZrFMnDG7mBMZ+SG63Mcm9rK3sS6f694zZPMLHfTWJm
         c+/pnKiyLZeo7rbRFypv9BdGcwEWHP3H5U/SsUNkrRft0xN8ythtUxSlB/HQTGASMCQE
         YDl2vF7ta4AxUYQntoZL+wGbFNBJb8DAxVf9GBZxT/+rovVlQFIUCjqFL1nI+vOqZQiD
         EaZfHc3YO9SgktYFXwrOt03LEBpQbmZ5+IJHOiZQ8MmltTYcqyCNBg355Cq9taovEMGs
         B3K7eblsyIIkNnt/JM/qi8oCAuAHGJycm6cXzhobq/++7QZy89pYt+7KM++akG64vLqg
         9Xdg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=t8oX1eG8;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=t8oX1eG8;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x227Q3pzvM1GylU05VYDgsU/qKQz6rNYhF/imtcuvJ78NsGK+7f7oAKQL/p5Hl8ZM1+QUcWIiCA==
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Jeremy Kerr <jk@ozlabs.org>,
	Christopher Bostic <cbostic@linux.vnet.ibm.com>,
	Brad Bishop <bradleyb@fuzziesquirrel.com>,
	Edward James <eajames@us.ibm.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 05/10] dt-bindings: fsi: Add specification for FSI busses
Date: Mon, 12 Feb 2018 15:45:44 +1030
Message-Id: <20180212051549.8575-6-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212051549.8575-1-joel@jms.id.au>
References: <20180212051549.8575-1-joel@jms.id.au>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592171026916612795?=
X-GMAIL-MSGID: =?utf-8?q?1592171026916612795?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jeremy Kerr <jk@ozlabs.org>

This change introduces a proposed layout for describing FSI busses in
the device tree. While the bus is probe-able, we'd still like a method
of describing subordinate (eg i2c) busses that are behind FSI devices.

The FSI core will be responsible for matching probed slaves & engines to
their device tree nodes, so the FSI device drivers' probe() functions
will be passed a struct device with the appropriate of_node populated
where a matching DT node is found.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Acked-by: Joel Stanley <joel@jms.id.au>
Acked-by: Brad Bishop <bradleyb@fuzziesquirrel.com>
Acked-by: Eddie James <eajames@linux.vnet.ibm.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 Documentation/devicetree/bindings/fsi/fsi.txt | 144 ++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi.txt

diff --git a/Documentation/devicetree/bindings/fsi/fsi.txt b/Documentation/devicetree/bindings/fsi/fsi.txt
new file mode 100644
index 000000000000..4eaf488d4015
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/fsi.txt
@@ -0,0 +1,144 @@
+FSI bus & engine generic device tree bindings
+=============================================
+
+The FSI bus is probe-able, so the OS is able to enumerate FSI slaves, and
+engines within those slaves. However, we have a facility to match devicetree
+nodes to probed engines. This allows for fsi engines to expose non-probeable
+busses, which are then exposed by the device tree. For example, an FSI engine
+that is an I2C master - the I2C bus can be described by the device tree under
+the engine's device tree node.
+
+FSI masters may require their own DT nodes (to describe the master HW itself);
+that requirement is defined by the master's implementation, and is described by
+the fsi-master-* binding specifications.
+
+Under the masters' nodes, we can describe the bus topology using nodes to
+represent the FSI slaves and their slave engines. As a basic outline:
+
+  fsi-master {
+      /* top-level of FSI bus topology, bound to an FSI master driver and
+       * exposes an FSI bus */
+
+      fsi-slave@<link,id> {
+          /* this node defines the FSI slave device, and is handled
+           * entirely with FSI core code */
+
+          fsi-slave-engine@<addr> {
+              /* this node defines the engine endpoint & address range, which
+               * is bound to the relevant fsi device driver */
+               ...
+          };
+
+          fsi-slave-engine@<addr> {
+              ...
+          };
+
+      };
+  };
+
+Note that since the bus is probe-able, some (or all) of the topology may
+not be described; this binding only provides an optional facility for
+adding subordinate device tree nodes as children of FSI engines.
+
+FSI masters
+-----------
+
+FSI master nodes declare themselves as such with the "fsi-master" compatible
+value. It's likely that an implementation-specific compatible value will
+be needed as well, for example:
+
+    compatible = "fsi-master-gpio", "fsi-master";
+
+Since the master nodes describe the top-level of the FSI topology, they also
+need to declare the FSI-standard addressing scheme. This requires two cells for
+addresses (link index and slave ID), and no size:
+
+    #address-cells = <2>;
+    #size-cells = <0>;
+
+FSI slaves
+----------
+
+Slaves are identified by a (link-index, slave-id) pair, so require two cells
+for an address identifier. Since these are not a range, no size cells are
+required. For an example, a slave on link 1, with ID 2, could be represented
+as:
+
+    cfam@1,2 {
+        reg = <1 2>;
+	[...];
+    }
+
+Each slave provides an address-space, under which the engines are accessible.
+That address space has a maximum of 23 bits, so we use one cell to represent
+addresses and sizes in the slave address space:
+
+    #address-cells = <1>;
+    #size-cells = <1>;
+
+
+FSI engines (devices)
+---------------------
+
+Engines are identified by their address under the slaves' address spaces. We
+use a single cell for address and size. Engine nodes represent the endpoint
+FSI device, and are passed to those FSI device drivers' ->probe() functions.
+
+For example, for a slave using a single 0x400-byte page starting at address
+0xc00:
+
+    engine@c00 {
+        reg = <0xc00 0x400>;
+    };
+
+
+Full example
+------------
+
+Here's an example that illustrates:
+ - an FSI master
+   - connected to an FSI slave
+     - that contains an engine that is an I2C master
+       - connected to an I2C EEPROM
+
+The FSI master may be connected to additional slaves, and slaves may have
+additional engines, but they don't necessarily need to be describe in the
+device tree if no extra platform information is required.
+
+    /* The GPIO-based FSI master node, describing the top level of the
+     * FSI bus
+     */
+    gpio-fsi {
+        compatible = "fsi-master-gpio", "fsi-master";
+        #address-cells = <2>;
+        #size-cells = <0>;
+
+        /* A FSI slave (aka. CFAM) at link 0, ID 0. */
+        cfam@0,0 {
+            reg = <0 0>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            /* FSI engine at 0xc00, using a single page. In this example,
+             * it's an I2C master controller, so subnodes describe the
+             * I2C bus.
+             */
+            i2c-controller@c00 {
+                reg = <0xc00 0x400>;
+
+                /* Engine-specific data. In this case, we're describing an
+                 * I2C bus, so we're conforming to the generic I2C binding
+                 */
+                compatible = "some-vendor,fsi-i2c-controller";
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                /* I2C endpoint device: an Atmel EEPROM */
+                eeprom@50 {
+                    compatible = "atmel,24c256";
+                    reg = <0x50>;
+                    pagesize = <64>;
+                };
+            };
+        };
+    };
-- 
2.15.1
